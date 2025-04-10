import 'package:hive/hive.dart';
import '../models/artist.dart';

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 0;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(
      id: fields[0] as String?,
      name: fields[1] as String?,
      thumbUrl: fields[2] as String?,
      fanartUrl: fields[3] as String?,
      logoUrl: fields[4] as String?,
      genre: fields[5] as String?,
      country: fields[6] as String?,
      biographyEN: fields[7] as String?,
      biographyFR: fields[8] as String?,
      facebook: fields[9] as String?,
      twitter: fields[10] as String?,
      website: fields[11] as String?,
      formedYear: fields[12] as String?,
      style: fields[13] as String?,
      mood: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer.writeByte(15);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.name);
    writer.writeByte(2);
    writer.write(obj.thumbUrl);
    writer.writeByte(3);
    writer.write(obj.fanartUrl);
    writer.writeByte(4);
    writer.write(obj.logoUrl);
    writer.writeByte(5);
    writer.write(obj.genre);
    writer.writeByte(6);
    writer.write(obj.country);
    writer.writeByte(7);
    writer.write(obj.biographyEN);
    writer.writeByte(8);
    writer.write(obj.biographyFR);
    writer.writeByte(9);
    writer.write(obj.facebook);
    writer.writeByte(10);
    writer.write(obj.twitter);
    writer.writeByte(11);
    writer.write(obj.website);
    writer.writeByte(12);
    writer.write(obj.formedYear);
    writer.writeByte(13);
    writer.write(obj.style);
    writer.writeByte(14);
    writer.write(obj.mood);
  }
}