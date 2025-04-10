import 'package:hive/hive.dart';
import '../models/album.dart';

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 1;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      id: fields[0] as String?,
      artistId: fields[1] as String?,
      name: fields[2] as String?,
      artistName: fields[3] as String?,
      thumbUrl: fields[4] as String?,
      yearReleased: fields[5] as String?,
      genre: fields[6] as String?,
      descriptionEN: fields[7] as String?,
      descriptionFR: fields[8] as String?,
      label: fields[9] as String?,
      cdArtUrl: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer.writeByte(11);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.artistId);
    writer.writeByte(2);
    writer.write(obj.name);
    writer.writeByte(3);
    writer.write(obj.artistName);
    writer.writeByte(4);
    writer.write(obj.thumbUrl);
    writer.writeByte(5);
    writer.write(obj.yearReleased);
    writer.writeByte(6);
    writer.write(obj.genre);
    writer.writeByte(7);
    writer.write(obj.descriptionEN);
    writer.writeByte(8);
    writer.write(obj.descriptionFR);
    writer.writeByte(9);
    writer.write(obj.label);
    writer.writeByte(10);
    writer.write(obj.cdArtUrl);
  }
}