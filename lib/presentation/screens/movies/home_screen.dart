import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomeView(), bottomNavigationBar: CustomBottomNavigationBar());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
          titlePadding: EdgeInsets.all(0),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppBar(),
            MoviesSlidesShow(movies: slideShowMovies),
            MoviesHorizontalListView(
                movies: nowPlayingMovies,
                title: "En cines",
                subtitle: "Noviembre",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),
            MoviesHorizontalListView(
                movies: nowPlayingMovies,
                title: "Próximamente",
                subtitle: "En este mes",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),
            MoviesHorizontalListView(
                movies: nowPlayingMovies,
                title: "Populares",
                subtitle: "En este mes",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),
            MoviesHorizontalListView(
                movies: nowPlayingMovies,
                title: "Mejor calificadas",
                subtitle: "Todos los tiempos",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
