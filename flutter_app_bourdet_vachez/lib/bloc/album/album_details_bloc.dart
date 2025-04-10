import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/album.dart';
import '../../data/models/track.dart';
import '../../repository/music_repository.dart';

// Events
abstract class AlbumDetailsEvent extends Equatable {
  const AlbumDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbumDetails extends AlbumDetailsEvent {
  final String albumId;

  const LoadAlbumDetails(this.albumId);

  @override
  List<Object> get props => [albumId];
}

// States
abstract class AlbumDetailsState extends Equatable {
  const AlbumDetailsState();

  @override
  List<Object> get props => [];
}

class AlbumDetailsInitial extends AlbumDetailsState {}

class AlbumDetailsLoading extends AlbumDetailsState {}

class AlbumDetailsLoaded extends AlbumDetailsState {
  final Album album;
  final List<Track> tracks;

  const AlbumDetailsLoaded({
    required this.album,
    required this.tracks,
  });

  @override
  List<Object> get props => [album, tracks];
}

class AlbumDetailsError extends AlbumDetailsState {
  final String message;

  const AlbumDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  final MusicRepository repository;

  AlbumDetailsBloc({required this.repository}) : super(AlbumDetailsInitial()) {
    on<LoadAlbumDetails>(_onLoadAlbumDetails);
  }

  Future<void> _onLoadAlbumDetails(LoadAlbumDetails event, Emitter<AlbumDetailsState> emit) async {
    emit(AlbumDetailsLoading());
    try {
      final album = await repository.getAlbumDetails(event.albumId);
      if (album == null) {
        emit(const AlbumDetailsError('Album non trouvé'));
        return;
      }
      
      final tracks = await repository.getAlbumTracks(event.albumId);
      
      emit(AlbumDetailsLoaded(album: album, tracks: tracks));
    } catch (e) {
      emit(AlbumDetailsError(e.toString()));
    }
  }
}