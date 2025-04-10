import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/artist.dart';
import '../../data/models/album.dart';
import '../../repository/favorites_repository.dart';

// Events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavoriteArtist extends FavoritesEvent {
  final Artist artist;

  const AddFavoriteArtist(this.artist);

  @override
  List<Object> get props => [artist];
}

class RemoveFavoriteArtist extends FavoritesEvent {
  final String artistId;

  const RemoveFavoriteArtist(this.artistId);

  @override
  List<Object> get props => [artistId];
}

class AddFavoriteAlbum extends FavoritesEvent {
  final Album album;

  const AddFavoriteAlbum(this.album);

  @override
  List<Object> get props => [album];
}

class RemoveFavoriteAlbum extends FavoritesEvent {
  final String albumId;

  const RemoveFavoriteAlbum(this.albumId);

  @override
  List<Object> get props => [albumId];
}

// States
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Artist> artists;
  final List<Album> albums;
  final Map<String, bool> favoriteArtistsMap;
  final Map<String, bool> favoriteAlbumsMap;

  const FavoritesLoaded({
    required this.artists,
    required this.albums,
    required this.favoriteArtistsMap,
    required this.favoriteAlbumsMap,
  });

  @override
  List<Object> get props => [artists, albums, favoriteArtistsMap, favoriteAlbumsMap];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc({required this.repository}) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteArtist>(_onAddFavoriteArtist);
    on<RemoveFavoriteArtist>(_onRemoveFavoriteArtist);
    on<AddFavoriteAlbum>(_onAddFavoriteAlbum);
    on<RemoveFavoriteAlbum>(_onRemoveFavoriteAlbum);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final artists = await repository.getFavoriteArtists();
      final albums = await repository.getFavoriteAlbums();
      
      final favoriteArtistsMap = <String, bool>{};
      final favoriteAlbumsMap = <String, bool>{};
      
      for (var artist in artists) {
        if (artist.id != null) {
          favoriteArtistsMap[artist.id!] = true;
        }
      }
      
      for (var album in albums) {
        if (album.id != null) {
          favoriteAlbumsMap[album.id!] = true;
        }
      }
      
      emit(FavoritesLoaded(
        artists: artists,
        albums: albums,
        favoriteArtistsMap: favoriteArtistsMap,
        favoriteAlbumsMap: favoriteAlbumsMap,
      ));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavoriteArtist(AddFavoriteArtist event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      try {
        await repository.addFavoriteArtist(event.artist);
        
        final artists = await repository.getFavoriteArtists();
        final favoriteArtistsMap = Map<String, bool>.from(currentState.favoriteArtistsMap);
        
        if (event.artist.id != null) {
          favoriteArtistsMap[event.artist.id!] = true;
        }
        
        emit(FavoritesLoaded(
          artists: artists,
          albums: currentState.albums,
          favoriteArtistsMap: favoriteArtistsMap,
          favoriteAlbumsMap: currentState.favoriteAlbumsMap,
        ));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveFavoriteArtist(RemoveFavoriteArtist event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      try {
        await repository.removeFavoriteArtist(event.artistId);
        
        final artists = await repository.getFavoriteArtists();
        final favoriteArtistsMap = Map<String, bool>.from(currentState.favoriteArtistsMap);
        
        favoriteArtistsMap.remove(event.artistId);
        
        emit(FavoritesLoaded(
          artists: artists,
          albums: currentState.albums,
          favoriteArtistsMap: favoriteArtistsMap,
          favoriteAlbumsMap: currentState.favoriteAlbumsMap,
        ));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  Future<void> _onAddFavoriteAlbum(AddFavoriteAlbum event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      try {
        await repository.addFavoriteAlbum(event.album);
        
        final albums = await repository.getFavoriteAlbums();
        final favoriteAlbumsMap = Map<String, bool>.from(currentState.favoriteAlbumsMap);
        
        if (event.album.id != null) {
          favoriteAlbumsMap[event.album.id!] = true;
        }
        
        emit(FavoritesLoaded(
          artists: currentState.artists,
          albums: albums,
          favoriteArtistsMap: currentState.favoriteArtistsMap,
          favoriteAlbumsMap: favoriteAlbumsMap,
        ));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveFavoriteAlbum(RemoveFavoriteAlbum event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      try {
        await repository.removeFavoriteAlbum(event.albumId);
        
        final albums = await repository.getFavoriteAlbums();
        final favoriteAlbumsMap = Map<String, bool>.from(currentState.favoriteAlbumsMap);
        
        favoriteAlbumsMap.remove(event.albumId);
        
        emit(FavoritesLoaded(
          artists: currentState.artists,
          albums: albums,
          favoriteArtistsMap: currentState.favoriteArtistsMap,
          favoriteAlbumsMap: favoriteAlbumsMap,
        ));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    }
  }
}