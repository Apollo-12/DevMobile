import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/charts/charts_bloc.dart';
import '../widgets/track_card.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class ChartsTab extends StatefulWidget {
  const ChartsTab({super.key});

  @override
  State<ChartsTab> createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ChartsBloc>().add(LoadCharts());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: const [
              Tab(text: 'Titres'),
              Tab(text: 'Albums'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTracksList(),
              const Center(child: Text('Classements des albums à venir')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTracksList() {
    return BlocBuilder<ChartsBloc, ChartsState>(
      builder: (context, state) {
        if (state is ChartsLoading) {
          return const LoadingWidget();
        } else if (state is ChartsLoaded) {
          if (state.tracks.isEmpty) {
            return const Center(
              child: Text('Aucun titre trouvé dans le classement'),
            );
          }
          return ListView.separated(
            itemCount: state.tracks.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final track = state.tracks[index];
              return TrackCard(
                track: track,
                index: index + 1,
              );
            },
          );
        } else if (state is ChartsError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<ChartsBloc>().add(LoadCharts());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}