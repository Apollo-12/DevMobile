import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  @JsonKey(name: 'idTrack')
  final String? id;

  @JsonKey(name: 'idAlbum')
  final String? albumId;

  @JsonKey(name: 'idArtist')
  final String? artistId;

  @JsonKey(name: 'strTrack')
  final String? name;

  @JsonKey(name: 'strArtist')
  final String? artistName;

  @JsonKey(name: 'strAlbum')
  final String? albumName;

  @JsonKey(name: 'strTrackThumb')
  final String? thumbUrl;

  @JsonKey(name: 'intDuration')
  final String? duration;

  @JsonKey(name: 'intTrackNumber')
  final String? trackNumber;

  @JsonKey(name: 'strMusicVid')
  final String? musicVideoUrl;

  @JsonKey(name: 'strGenre')
  final String? genre;

  Track({
    this.id,
    this.albumId,
    this.artistId,
    this.name,
    this.artistName,
    this.albumName,
    this.thumbUrl,
    this.duration,
    this.trackNumber,
    this.musicVideoUrl,
    this.genre,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class TrackResponse {
  @JsonKey(name: 'track')
  final List<Track>? tracks;

  TrackResponse({this.tracks});

  factory TrackResponse.fromJson(Map<String, dynamic> json) => _$TrackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
}