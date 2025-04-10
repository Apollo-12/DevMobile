import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/artist.dart';
import '../../data/models/album.dart';
import '../../repository/music_repository.dart';

// Events
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitialized extends SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

// States
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Artist> artists;
  final List<Album> albums;
  final String query;

  const SearchLoaded({
    required this.artists,
    required this.albums,
    required this.query,
  });

  @override
  List<Object> get props => [artists, albums, query];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicRepository repository;

  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<SearchInitialized>(_onSearchInitialized);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchInitialized(SearchInitialized event, Emitter<SearchState> emit) async {
    emit(SearchInitial());
  }

  Future<void> _onSearchQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final artists = await repository.searchArtists(event.query);
      final albums = await repository.searchAlbums(event.query);
      emit(SearchLoaded(artists: artists, albums: albums, query: event.query));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}