import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/track.dart';
import '../../repository/music_repository.dart';

// Events
abstract class ChartsEvent extends Equatable {
  const ChartsEvent();

  @override
  List<Object> get props => [];
}

class LoadCharts extends ChartsEvent {}

// States
abstract class ChartsState extends Equatable {
  const ChartsState();

  @override
  List<Object> get props => [];
}

class ChartsInitial extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List<Track> tracks;

  const ChartsLoaded(this.tracks);

  @override
  List<Object> get props => [tracks];
}

class ChartsError extends ChartsState {
  final String message;

  const ChartsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final MusicRepository repository;

  ChartsBloc({required this.repository}) : super(ChartsInitial()) {
    on<LoadCharts>(_onLoadCharts);
  }

  Future<void> _onLoadCharts(LoadCharts event, Emitter<ChartsState> emit) async {
    emit(ChartsLoading());
    try {
      final tracks = await repository.getTrendingTracks();
      emit(ChartsLoaded(tracks));
    } catch (e) {
      emit(ChartsError(e.toString()));
    }
  }
}