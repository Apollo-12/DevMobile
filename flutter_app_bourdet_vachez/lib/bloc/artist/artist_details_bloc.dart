import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/artist.dart';
import '../../data/models/album.dart';
import '../../repository/music_repository.dart';

// Events
abstract class ArtistDetailsEvent extends Equatable {
  const ArtistDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadArtistDetails extends ArtistDetailsEvent {
  final String artistId;

  const LoadArtistDetails(this.artistId);

  @override
  List<Object> get props => [artistId];
}

// States
abstract class ArtistDetailsState extends Equatable {
  const ArtistDetailsState();

  @override
  List<Object> get props => [];
}

class ArtistDetailsInitial extends ArtistDetailsState {}

class ArtistDetailsLoading extends ArtistDetailsState {}

class ArtistDetailsLoaded extends ArtistDetailsState {
  final Artist artist;
  final List<Album> albums;

  const ArtistDetailsLoaded({
    required this.artist,
    required this.albums,
  });

  @override
  List<Object> get props => [artist, albums];
}

class ArtistDetailsError extends ArtistDetailsState {
  final String message;

  const ArtistDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ArtistDetailsBloc extends Bloc<ArtistDetailsEvent, ArtistDetailsState> {
  final MusicRepository repository;

  ArtistDetailsBloc({required this.repository}) : super(ArtistDetailsInitial()) {
    on<LoadArtistDetails>(_onLoadArtistDetails);
  }

  Future<void> _onLoadArtistDetails(LoadArtistDetails event, Emitter<ArtistDetailsState> emit) async {
    emit(ArtistDetailsLoading());
    try {
      final artist = await repository.getArtistDetails(event.artistId);
      if (artist == null) {
        emit(const ArtistDetailsError('Artiste non trouvé'));
        return;
      }
      
      final albums = await repository.getArtistAlbums(event.artistId);
      
      emit(ArtistDetailsLoaded(artist: artist, albums: albums));
    } catch (e) {
      emit(ArtistDetailsError(e.toString()));
    }
  }
}
