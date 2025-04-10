// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['idTrack'] as String?,
      albumId: json['idAlbum'] as String?,
      artistId: json['idArtist'] as String?,
      name: json['strTrack'] as String?,
      artistName: json['strArtist'] as String?,
      albumName: json['strAlbum'] as String?,
      thumbUrl: json['strTrackThumb'] as String?,
      duration: json['intDuration'] as String?,
      trackNumber: json['intTrackNumber'] as String?,
      musicVideoUrl: json['strMusicVid'] as String?,
      genre: json['strGenre'] as String?,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'idTrack': instance.id,
      'idAlbum': instance.albumId,
      'idArtist': instance.artistId,
      'strTrack': instance.name,
      'strArtist': instance.artistName,
      'strAlbum': instance.albumName,
      'strTrackThumb': instance.thumbUrl,
      'intDuration': instance.duration,
      'intTrackNumber': instance.trackNumber,
      'strMusicVid': instance.musicVideoUrl,
      'strGenre': instance.genre,
    };

TrackResponse _$TrackResponseFromJson(Map<String, dynamic> json) =>
    TrackResponse(
      tracks: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackResponseToJson(TrackResponse instance) =>
    <String, dynamic>{
      'track': instance.tracks,
    };
