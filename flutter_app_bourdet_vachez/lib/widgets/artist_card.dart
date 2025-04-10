import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/artist.dart';
import 'network_image.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: artist.thumbUrl != null
              ? Image.network(
                  artist.thumbUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person),
                ),
        ),
      ),
      title: Text(
        artist.name ?? 'Artiste inconnu',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: artist.id != null
          ? () => context.push('/artist/${artist.id}')
          : null,
    );
  }
}