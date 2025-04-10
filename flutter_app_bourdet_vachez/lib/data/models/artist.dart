import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
  @JsonKey(name: 'idArtist')
  final String? id;

  @JsonKey(name: 'strArtist')
  final String? name;

  @JsonKey(name: 'strArtistThumb')
  final String? thumbUrl;

  @JsonKey(name: 'strArtistFanart')
  final String? fanartUrl;

  @JsonKey(name: 'strArtistLogo')
  final String? logoUrl;

  @JsonKey(name: 'strGenre')
  final String? genre;

  @JsonKey(name: 'strCountry')
  final String? country;

  @JsonKey(name: 'strBiographyEN')
  final String? biographyEN;

  @JsonKey(name: 'strBiographyFR')
  final String? biographyFR;

  @JsonKey(name: 'strFacebook')
  final String? facebook;

  @JsonKey(name: 'strTwitter')
  final String? twitter;

  @JsonKey(name: 'strWebsite')
  final String? website;

  @JsonKey(name: 'intFormedYear')
  final String? formedYear;

  @JsonKey(name: 'strStyle')
  final String? style;

  @JsonKey(name: 'strMood')
  final String? mood;

  Artist({
    this.id,
    this.name,
    this.thumbUrl,
    this.fanartUrl,
    this.logoUrl,
    this.genre,
    this.country,
    this.biographyEN,
    this.biographyFR,
    this.facebook,
    this.twitter,
    this.website,
    this.formedYear,
    this.style,
    this.mood,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class ArtistResponse {
  @JsonKey(name: 'artists')
  final List<Artist>? artists;

  ArtistResponse({this.artists});

  factory ArtistResponse.fromJson(Map<String, dynamic> json) => _$ArtistResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}