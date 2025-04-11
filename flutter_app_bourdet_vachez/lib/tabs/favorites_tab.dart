import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../widgets/artist_card.dart';
import '../widgets/album_card.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const LoadingWidget();
        } else if (state is FavoritesLoaded) {
          return _buildFavoritesList(state);
        } else if (state is FavoritesError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<FavoritesBloc>().add(LoadFavorites());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFavoritesList(FavoritesLoaded state) {
    if (state.artists.isEmpty && state.albums.isEmpty) {
      return const Center(
        child: Text(
          'Vous n\'avez pas encore de favoris.\nRecherchez des artistes ou des albums et ajoutez-les à vos favoris.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0),
          child: Text(
            'Mes artistes & albums',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        if (state.artists.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Artistes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...state.artists.map((artist) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: ArtistCard(artist: artist),
            );
          }).toList(),
        ],
        if (state.albums.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Albums',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...state.albums.map((album) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: AlbumCard(album: album),
            );
          }).toList(),
        ],
      ],
    );
  }
}