import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: album.thumbUrl != null
            ? Image.network(
                album.thumbUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Container(
                color: Colors.grey[300],
                child: const Icon(Icons.album),
              ),
      ),
      title: Text(
        album.name ?? 'Album inconnu',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        album.artistName ?? 'Artiste inconnu',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: album.id != null
          ? () => context.push('/album/${album.id}')
          : null,
    );
  }
}