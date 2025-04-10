import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/artist_details_screen.dart';
import '../screens/album_details_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/artist/:id',
        pageBuilder: (context, state) {
          final artistId = state.pathParameters['id'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: ArtistDetailsScreen(artistId: artistId),
          );
        },
      ),
      GoRoute(
        path: '/album/:id',
        pageBuilder: (context, state) {
          final albumId = state.pathParameters['id'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: AlbumDetailsScreen(albumId: albumId),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Erreur')),
        body: Center(
          child: Text('Page non trouvée: ${state.uri}'),
        ),
      ),
    ),
  );
}