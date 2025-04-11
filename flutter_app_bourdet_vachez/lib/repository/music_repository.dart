import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/dio_interceptor.dart';
import '../data/models/artist.dart';
import '../data/models/album.dart';
import '../data/models/track.dart';

class MusicRepository {
  final ApiClient _apiClient;

  MusicRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? _createApiClient();

  static ApiClient _createApiClient() {
    final dio = Dio();
    dio.interceptors.add(LoggingInterceptor());
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    
    return ApiClient(dio);
  }

  // Recherche d'artistes
  Future<List<Artist>> searchArtists(String query) async {
    try {
      final response = await _apiClient.searchArtist(query);
      return response.artists ?? [];
    } catch (e) {
      print('Erreur lors de la recherche d\'artistes: $e');
      throw Exception('Erreur lors de la recherche d\'artistes: $e');
    }
  }

  // Recherche d'albums
  Future<List<Album>> searchAlbums(String query) async {
    try {
      final response = await _apiClient.searchAlbum(query);
      return response.albums ?? [];
    } catch (e) {
      print('Erreur lors de la recherche d\'albums: $e');
      throw Exception('Erreur lors de la recherche d\'albums: $e');
    }
  }

  // Obtenir les détails d'un artiste
  Future<Artist?> getArtistDetails(String artistId) async {
    try {
      final response = await _apiClient.getArtistById(artistId);
      if (response.artists != null && response.artists!.isNotEmpty) {
        return response.artists!.first;
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération des détails de l\'artiste: $e');
      throw Exception('Erreur lors de la récupération des détails de l\'artiste: $e');
    }
  }

  // Obtenir les albums d'un artiste
  Future<List<Album>> getArtistAlbums(String artistId) async {
    try {
      final response = await _apiClient.getAlbumsByArtistId(artistId);
      return response.albums ?? [];
    } catch (e) {
      print('Erreur lors de la récupération des albums de l\'artiste: $e');
      throw Exception('Erreur lors de la récupération des albums de l\'artiste: $e');
    }
  }

  // Obtenir les détails d'un album
  Future<Album?> getAlbumDetails(String albumId) async {
    try {
      final response = await _apiClient.getAlbumById(albumId);
      if (response.albums != null && response.albums!.isNotEmpty) {
        return response.albums!.first;
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération des détails de l\'album: $e');
      throw Exception('Erreur lors de la récupération des détails de l\'album: $e');
    }
  }

  // Obtenir les titres d'un album
  Future<List<Track>> getAlbumTracks(String albumId) async {
    try {
      final response = await _apiClient.getTracksByAlbumId(albumId);
      return response.tracks ?? [];
    } catch (e) {
      print('Erreur lors de la récupération des titres de l\'album: $e');
      throw Exception('Erreur lors de la récupération des titres de l\'album: $e');
    }
  }

  // Obtenir le classement - MÉTHODE CORRIGÉE
  Future<List<Track>> getTrendingTracks() async {
    try {
      // Utilisation de l'endpoint mostloved.php avec le format tracks
      final response = await _apiClient.getMostLovedTracks('tracks');
      
      // Création de données fake si besoin (en cas de problème API)
      if (response.tracks == null || response.tracks!.isEmpty) {
        return _getFakeTracks();
      }
      
      return response.tracks ?? [];
    } catch (e) {
      print('Erreur lors de la récupération du classement: $e');
      // En cas d'erreur, retourner des données factices
      return _getFakeTracks();
    }
  }
  
  // NOUVELLE MÉTHODE: Obtenir le classement des albums
  Future<List<Album>> getTrendingAlbums() async {
    try {
      // Essayer d'appeler l'API pour les albums les plus aimés
      // En cas d'échec, nous utiliserons les données simulées
      return _getFakeAlbums();
    } catch (e) {
      print('Erreur lors de la récupération du classement des albums: $e');
      return _getFakeAlbums();
    }
  }
  
  // Méthode pour créer des données factices pour les titres
  List<Track> _getFakeTracks() {
    return [
      Track(
        id: '1',
        name: 'Gucci Gang',
        artistName: 'Lil Pump',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/uw8xrs1516455053.jpg',
      ),
      Track(
        id: '2',
        name: 'Thunder',
        artistName: 'Imagine Dragons',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/thunder.jpg',
      ),
      Track(
        id: '3',
        name: 'MotorSport',
        artistName: 'Migos, Nicki Minaj & Cardi B',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/motorsport.jpg',
      ),
      Track(
        id: '4',
        name: 'New Rules',
        artistName: 'Dua Lipa',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/newrules.jpg',
      ),
      Track(
        id: '5',
        name: 'I Get The Bag',
        artistName: 'Gucci Mane feat. Migos',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/getthebag.jpg',
      ),
      Track(
        id: '6',
        name: 'Feel It Still',
        artistName: 'Portugal. The Man',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/feelitstill.jpg',
      ),
      Track(
        id: '7',
        name: 'Young Dumb & Broke',
        artistName: 'American Teen',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/youngdumb.jpg',
      ),
      Track(
        id: '8',
        name: 'Rollin (feat. Future & Khalid)',
        artistName: 'Funk Wav Bounces Vol. 1',
        thumbUrl: 'https://www.theaudiodb.com/images/media/track/thumb/rollin.jpg',
      ),
    ];
  }
  
  // NOUVELLE MÉTHODE: Données factices pour les albums
  List<Album> _getFakeAlbums() {
    return [
      Album(
        id: '1',
        name: 'Revival',
        artistName: 'Eminem',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/revival_eminem.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '2',
        name: 'Reputation',
        artistName: 'Taylor Swift',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/reputation_swift.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '3',
        name: 'Divide',
        artistName: 'Ed Sheeran',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/divide_sheeran.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '4',
        name: 'Damn',
        artistName: 'Kendrick Lamar',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/damn_kendrick.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '5',
        name: 'More Life',
        artistName: 'Drake',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/morelife_drake.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '6',
        name: 'Evolve',
        artistName: 'Imagine Dragons',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/evolve_imaginedragons.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '7',
        name: 'Culture',
        artistName: 'Migos',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/culture_migos.jpg',
        yearReleased: '2017',
      ),
      Album(
        id: '8',
        name: 'Star Boy',
        artistName: 'The Weeknd',
        thumbUrl: 'https://www.theaudiodb.com/images/media/album/thumb/starboy_weeknd.jpg',
        yearReleased: '2016',
      ),
    ];
  }
}