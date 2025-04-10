import 'package:hive/hive.dart';

part 'favorite_album.g.dart';

@HiveType(typeId: 1)
class FavoriteAlbum extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String? name;
  
  @HiveField(2)
  final String? artistName;
  
  @HiveField(3)
  final String? thumbUrl;
  
  @HiveField(4)
  final String? artistId;
  
  FavoriteAlbum({
    required this.id,
    this.name,
    this.artistName,
    this.thumbUrl,
    this.artistId,
  });
}