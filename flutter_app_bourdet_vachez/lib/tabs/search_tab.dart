import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/artist_card.dart';
import '../widgets/album_card.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchInitialized());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un artiste ou un album',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty 
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      context.read<SearchBloc>().add(SearchInitialized());
                    },
                  )
                : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            ),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<SearchBloc>().add(SearchQueryChanged(query));
              } else {
                context.read<SearchBloc>().add(SearchInitialized());
              }
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const LoadingWidget();
              } else if (state is SearchLoaded) {
                return _buildSearchResults(state);
              } else if (state is SearchError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () {
                    if (_searchController.text.isNotEmpty) {
                      context.read<SearchBloc>().add(SearchQueryChanged(_searchController.text));
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text('Recherchez un artiste ou un album'),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(SearchLoaded state) {
    if (state.artists.isEmpty && state.albums.isEmpty) {
      return Center(
        child: Text('Aucun résultat trouvé pour "${state.query}"'),
      );
    }

    return ListView(
      children: [
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