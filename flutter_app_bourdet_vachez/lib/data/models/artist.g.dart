// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['idArtist'] as String?,
      name: json['strArtist'] as String?,
      thumbUrl: json['strArtistThumb'] as String?,
      fanartUrl: json['strArtistFanart'] as String?,
      logoUrl: json['strArtistLogo'] as String?,
      genre: json['strGenre'] as String?,
      country: json['strCountry'] as String?,
      biographyEN: json['strBiographyEN'] as String?,
      biographyFR: json['strBiographyFR'] as String?,
      facebook: json['strFacebook'] as String?,
      twitter: json['strTwitter'] as String?,
      website: json['strWebsite'] as String?,
      formedYear: json['intFormedYear'] as String?,
      style: json['strStyle'] as String?,
      mood: json['strMood'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.name,
      'strArtistThumb': instance.thumbUrl,
      'strArtistFanart': instance.fanartUrl,
      'strArtistLogo': instance.logoUrl,
      'strGenre': instance.genre,
      'strCountry': instance.country,
      'strBiographyEN': instance.biographyEN,
      'strBiographyFR': instance.biographyFR,
      'strFacebook': instance.facebook,
      'strTwitter': instance.twitter,
      'strWebsite': instance.website,
      'intFormedYear': instance.formedYear,
      'strStyle': instance.style,
      'strMood': instance.mood,
    };

ArtistResponse _$ArtistResponseFromJson(Map<String, dynamic> json) =>
    ArtistResponse(
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistResponseToJson(ArtistResponse instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
