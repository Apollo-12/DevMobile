import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  @JsonKey(name: 'idAlbum')
  final String? id;

  @JsonKey(name: 'idArtist')
  final String? artistId;

  @JsonKey(name: 'strAlbum')
  final String? name;

  @JsonKey(name: 'strArtist')
  final String? artistName;

  @JsonKey(name: 'strAlbumThumb')
  final String? thumbUrl;

  @JsonKey(name: 'intYearReleased')
  final String? yearReleased;

  @JsonKey(name: 'strGenre')
  final String? genre;

  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEN;

  @JsonKey(name: 'strDescriptionFR')
  final String? descriptionFR;

  @JsonKey(name: 'strLabel')
  final String? label;

  @JsonKey(name: 'strAlbumCDart')
  final String? cdArtUrl;

  Album({
    this.id,
    this.artistId,
    this.name,
    this.artistName,
    this.thumbUrl,
    this.yearReleased,
    this.genre,
    this.descriptionEN,
    this.descriptionFR,
    this.label,
    this.cdArtUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class AlbumResponse {
  @JsonKey(name: 'album')
  final List<Album>? albums;

  AlbumResponse({this.albums});

  factory AlbumResponse.fromJson(Map<String, dynamic> json) => _$AlbumResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}