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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: ListTile(
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
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.album),
                  ),
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
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          album.artistName ?? 'Artiste inconnu',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: album.id != null
            ? () => context.push('/album/${album.id}')
            : null,
      ),
    );
  }
}