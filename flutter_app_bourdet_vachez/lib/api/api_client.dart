import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

import '../data/models/artist.dart';
import '../data/models/album.dart';
import '../data/models/track.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/523532")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Recherche d'artistes
  @GET("/search.php")
  Future<ArtistResponse> searchArtist(@Query("s") String artistName);

  // Recherche d'albums
  @GET("/searchalbum.php")
  Future<AlbumResponse> searchAlbum(@Query("s") String albumName);

  // Obtenir les détails d'un artiste par ID
  @GET("/artist.php")
  Future<ArtistResponse> getArtistById(@Query("i") String artistId);

  // Obtenir les albums d'un artiste par ID
  @GET("/album.php")
  Future<AlbumResponse> getAlbumsByArtistId(@Query("i") String artistId);

  // Obtenir les détails d'un album par ID
  @GET("/album.php")
  Future<AlbumResponse> getAlbumById(@Query("m") String albumId);

  // Obtenir les titres d'un album par ID
  @GET("/track.php")
  Future<TrackResponse> getTracksByAlbumId(@Query("m") String albumId);

  // Obtenir le classement iTunes US
  @GET("/trending.php")
  Future<TrackResponse> getTrendingTracks(@Query("country") String country, @Query("type") String type);
}