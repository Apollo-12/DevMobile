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
    dio.options.connectTimeout = const Duration(seconds: 30); // Timeout augmenté
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

  // Obtenir le classement iTunes US
  Future<List<Track>> getTrendingTracks({String country = 'us', String type = 'itunes'}) async {
    try {
      final response = await _apiClient.getTrendingTracks(country, type);
      return response.tracks ?? [];
    } catch (e) {
      print('Erreur lors de la récupération du classement: $e');
      // Retourner une liste vide en cas d'erreur pour éviter un crash
      return [];
    }
  }
}