import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/track.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  final int index;

  const TrackCard({
    super.key,
    required this.track,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 48,
            height: 48,
            child: track.thumbUrl != null
                ? Image.network(
                    track.thumbUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.music_note),
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note),
                  ),
          ),
        ],
      ),
      title: Text(
        track.name ?? 'Titre inconnu',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        track.artistName ?? 'Artiste inconnu',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
      onTap: track.artistId != null
          ? () => context.push('/artist/${track.artistId}')
          : null,
    );
  }
}