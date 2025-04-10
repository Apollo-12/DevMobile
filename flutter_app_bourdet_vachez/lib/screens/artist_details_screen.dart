import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/artist/artist_details_bloc.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../data/models/artist.dart';
import '../data/models/album.dart';
import '../widgets/album_card.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class ArtistDetailsScreen extends StatefulWidget {
  final String artistId;

  const ArtistDetailsScreen({super.key, required this.artistId});

  @override
  State<ArtistDetailsScreen> createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArtistDetailsBloc>().add(LoadArtistDetails(widget.artistId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArtistDetailsBloc, ArtistDetailsState>(
        builder: (context, state) {
          if (state is ArtistDetailsLoading) {
            return const LoadingWidget();
          } else if (state is ArtistDetailsLoaded) {
            return _buildArtistDetails(context, state.artist, state.albums);
          } else if (state is ArtistDetailsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ArtistDetailsBloc>().add(LoadArtistDetails(widget.artistId));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildArtistDetails(BuildContext context, Artist artist, List<Album> albums) {
    final isFavorite = context
        .watch<FavoritesBloc>()
        .state is FavoritesLoaded
        ? (context.watch<FavoritesBloc>().state as FavoritesLoaded)
            .favoriteArtistsMap
            .containsKey(artist.id)
        : false;

    // Sélectionner la biographie en fonction de la langue
    final locale = Localizations.localeOf(context);
    String? biography;
    
    if (locale.languageCode == 'fr' && artist.biographyFR != null && artist.biographyFR!.isNotEmpty) {
      biography = artist.biographyFR;
    } else {
      biography = artist.biographyEN;
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: artist.fanartUrl != null
                ? Image.network(
                    artist.fanartUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.grey),
            title: Text(
              artist.name ?? 'Artiste inconnu',
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
                  context.read<FavoritesBloc>().add(RemoveFavoriteArtist(artist.id!));
                } else {
                  context.read<FavoritesBloc>().add(AddFavoriteArtist(artist));
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
                  if (artist.genre != null || artist.style != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        [artist.genre, artist.style]
                            .where((e) => e != null && e.isNotEmpty)
                            .join(' • '),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (biography != null && biography.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        biography,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  if (artist.website != null ||
                      artist.facebook != null ||
                      artist.twitter != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (artist.website != null)
                            IconButton(
                              icon: const Icon(Icons.language),
                              onPressed: () {
                                _launchUrl(artist.website!);
                              },
                            ),
                          if (artist.facebook != null)
                            IconButton(
                              icon: const Icon(Icons.facebook),
                              onPressed: () {
                                _launchUrl('https://facebook.com/${artist.facebook}');
                              },
                            ),
                          if (artist.twitter != null)
                            IconButton(
                              icon: const Icon(Icons.tag),
                              onPressed: () {
                                _launchUrl('https://twitter.com/${artist.twitter}');
                              },
                            ),
                        ],
                      ),
                    ),
                  const Text(
                    'Albums',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (albums.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Aucun album trouvé'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return AlbumCard(album: album);
                },
              ),
          ]),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}