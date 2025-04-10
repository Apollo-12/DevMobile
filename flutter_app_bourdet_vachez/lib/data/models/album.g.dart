// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String?,
      artistId: json['idArtist'] as String?,
      name: json['strAlbum'] as String?,
      artistName: json['strArtist'] as String?,
      thumbUrl: json['strAlbumThumb'] as String?,
      yearReleased: json['intYearReleased'] as String?,
      genre: json['strGenre'] as String?,
      descriptionEN: json['strDescriptionEN'] as String?,
      descriptionFR: json['strDescriptionFR'] as String?,
      label: json['strLabel'] as String?,
      cdArtUrl: json['strAlbumCDart'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'idArtist': instance.artistId,
      'strAlbum': instance.name,
      'strArtist': instance.artistName,
      'strAlbumThumb': instance.thumbUrl,
      'intYearReleased': instance.yearReleased,
      'strGenre': instance.genre,
      'strDescriptionEN': instance.descriptionEN,
      'strDescriptionFR': instance.descriptionFR,
      'strLabel': instance.label,
      'strAlbumCDart': instance.cdArtUrl,
    };

AlbumResponse _$AlbumResponseFromJson(Map<String, dynamic> json) =>
    AlbumResponse(
      albums: (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumResponseToJson(AlbumResponse instance) =>
    <String, dynamic>{
      'album': instance.albums,
    };
