import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

import 'api/api_client.dart';
import 'bloc/charts/charts_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/artist/artist_details_bloc.dart';
import 'bloc/album/album_details_bloc.dart';
import 'repository/music_repository.dart';
import 'repository/favorites_repository.dart';
import 'utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Hive
  await Hive.initFlutter();
  
  // Initialiser le repository des favoris
  final favoritesRepository = FavoritesRepository();
  await favoritesRepository.init();
  
  // Forcer l'orientation portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MyApp(favoritesRepository: favoritesRepository));
}

class MyApp extends StatelessWidget {
  final FavoritesRepository favoritesRepository;
  
  const MyApp({super.key, required this.favoritesRepository});

  @override
  Widget build(BuildContext context) {
    final musicRepository = MusicRepository();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChartsBloc>(
          create: (context) => ChartsBloc(repository: musicRepository),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(repository: musicRepository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(repository: favoritesRepository),
        ),
        BlocProvider<ArtistDetailsBloc>(
          create: (context) => ArtistDetailsBloc(repository: musicRepository),
        ),
        BlocProvider<AlbumDetailsBloc>(
          create: (context) => AlbumDetailsBloc(repository: musicRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Music App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'SF Pro',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}