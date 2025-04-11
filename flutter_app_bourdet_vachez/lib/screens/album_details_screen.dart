import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/album/album_details_bloc.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../data/models/album.dart';
import '../data/models/track.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final String albumId;

  const AlbumDetailsScreen({super.key, required this.albumId});

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumDetailsBloc>().add(LoadAlbumDetails(widget.albumId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumDetailsBloc, AlbumDetailsState>(
        builder: (context, state) {
          if (state is AlbumDetailsLoading) {
            return const LoadingWidget();
          } else if (state is AlbumDetailsLoaded) {
            return _buildAlbumDetails(context, state.album, state.tracks);
          } else if (state is AlbumDetailsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<AlbumDetailsBloc>().add(LoadAlbumDetails(widget.albumId));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAlbumDetails(BuildContext context, Album album, List<Track> tracks) {
    final isFavorite = context
        .watch<FavoritesBloc>()
        .state is FavoritesLoaded
        ? (context.watch<FavoritesBloc>().state as FavoritesLoaded)
            .favoriteAlbumsMap
            .containsKey(album.id)
        : false;

    // Sélectionner la description en fonction de la langue
    final locale = Localizations.localeOf(context);
    String? description;
    
    if (locale.languageCode == 'fr' && album.descriptionFR != null && album.descriptionFR!.isNotEmpty) {
      description = album.descriptionFR;
    } else {
      description = album.descriptionEN;
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: album.thumbUrl != null
                ? Image.network(
                    album.thumbUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.grey),
            title: Text(
              album.name ?? 'Album inconnu',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                if (isFavorite) {
                  context.read<FavoritesBloc>().add(RemoveFavoriteAlbum(album.id!));
                } else {
                  context.read<FavoritesBloc>().add(AddFavoriteAlbum(album));
                }
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (album.artistName != null)
                        GestureDetector(
                          onTap: album.artistId != null
                              ? () => context.push('/artist/${album.artistId}')
                              : null,
                          child: Text(
                            album.artistName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const Spacer(),
                      if (album.yearReleased != null)
                        Text(
                          album.yearReleased!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (album.genre != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        album.genre!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (description != null && description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  const Text(
                    'Titres',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (tracks.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Aucun titre trouvé'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return ListTile(
                    leading: Text(
                      track.trackNumber ?? (index + 1).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(track.name ?? 'Titre inconnu'),
                    subtitle: Text(
                      _formatDuration(track.duration),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
          ]),
        ),
      ],
    );
  }

  String _formatDuration(String? durationStr) {
    if (durationStr == null || durationStr.isEmpty) {
      return '';
    }
    
    try {
      final seconds = int.parse(durationStr);
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      
      return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }
}