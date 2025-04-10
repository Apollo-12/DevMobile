// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAlbumAdapter extends TypeAdapter<FavoriteAlbum> {
  @override
  final int typeId = 1;

  @override
  FavoriteAlbum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteAlbum(
      id: fields[0] as String,
      name: fields[1] as String?,
      artistName: fields[2] as String?,
      thumbUrl: fields[3] as String?,
      artistId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteAlbum obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.thumbUrl)
      ..writeByte(4)
      ..write(obj.artistId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
