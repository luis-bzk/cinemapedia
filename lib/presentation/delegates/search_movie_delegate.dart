import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie_entity.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query , int page);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  Timer? _debounceTimer;
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();

  SearchMovieDelegate({required this.searchMovies});

  void cleanStreams() {
    debounceMovies.close();
  }

  void _onQueryChange(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (query.isEmpty) {
          debounceMovies.add([]);
          return;
        }

        final movies = await searchMovies( query, 1);
        debounceMovies.add(movies);
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty) FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear_rounded)
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        cleanStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);

    return StreamBuilder(
      // future: searchMovies(query: query, page: 1),
      stream: debounceMovies.stream,
      // initialData: const [],
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        // ! print('========== BUSCANDO MOVIES =============');
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                cleanStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),

            SizedBox(
              width: (size.width * 0.8) - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, 2),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
