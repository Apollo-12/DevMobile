import 'package:hive/hive.dart';
import '../data/models/artist.dart';
import '../data/models/album.dart';
import '../data/models/favorite_artist.dart';
import '../data/models/favorite_album.dart';

class FavoritesRepository {
  static const String _artistBoxName = 'favorite_artists';
  static const String _albumBoxName = 'favorite_albums';

  // Initialiser Hive
  Future<void> init() async {
    Hive.registerAdapter(FavoriteArtistAdapter());
    Hive.registerAdapter(FavoriteAlbumAdapter());
    
    await Hive.openBox<FavoriteArtist>(_artistBoxName);
    await Hive.openBox<FavoriteAlbum>(_albumBoxName);
  }

  // Méthodes pour les artistes favoris
  Future<List<Artist>> getFavoriteArtists() async {
    final box = Hive.box<FavoriteArtist>(_artistBoxName);
    
    return box.values.map((favorite) => Artist(
      id: favorite.id,
      name: favorite.name,
      thumbUrl: favorite.thumbUrl,
      genre: favorite.genre,
    )).toList();
  }

  Future<void> addFavoriteArtist(Artist artist) async {
    if (artist.id == null) return;
    
    final box = Hive.box<FavoriteArtist>(_artistBoxName);
    final favoriteArtist = FavoriteArtist(
      id: artist.id!,
      name: artist.name,
      thumbUrl: artist.thumbUrl,
      genre: artist.genre,
    );
    
    await box.put(artist.id, favoriteArtist);
  }

  Future<void> removeFavoriteArtist(String artistId) async {
    final box = Hive.box<FavoriteArtist>(_artistBoxName);
    await box.delete(artistId);
  }

  bool isArtistFavorite(String artistId) {
    final box = Hive.box<FavoriteArtist>(_artistBoxName);
    return box.containsKey(artistId);
  }

  // Méthodes pour les albums favoris
  Future<List<Album>> getFavoriteAlbums() async {
    final box = Hive.box<FavoriteAlbum>(_albumBoxName);
    
    return box.values.map((favorite) => Album(
      id: favorite.id,
      name: favorite.name,
      artistName: favorite.artistName,
      thumbUrl: favorite.thumbUrl,
      artistId: favorite.artistId,
    )).toList();
  }

  Future<void> addFavoriteAlbum(Album album) async {
    if (album.id == null) return;
    
    final box = Hive.box<FavoriteAlbum>(_albumBoxName);
    final favoriteAlbum = FavoriteAlbum(
      id: album.id!,
      name: album.name,
      artistName: album.artistName,
      thumbUrl: album.thumbUrl,
      artistId: album.artistId,
    );
    
    await box.put(album.id, favoriteAlbum);
  }

  Future<void> removeFavoriteAlbum(String albumId) async {
    final box = Hive.box<FavoriteAlbum>(_albumBoxName);
    await box.delete(albumId);
  }

  bool isAlbumFavorite(String albumId) {
    final box = Hive.box<FavoriteAlbum>(_albumBoxName);
    return box.containsKey(albumId);
  }
}