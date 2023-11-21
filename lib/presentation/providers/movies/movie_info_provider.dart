import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider).getMovieDetails;
  return MovieMapNotifier(getMovie: fetchMovie);
});

typedef GetMovieData = Future<Movie> Function(String);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieData getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieID) async {
    if (state[movieID] != null) return;
    print('||========= REALIZANDO PETICION HTTP =========||');
    final movie = await getMovie(movieID);

    state = {...state, movieID: movie};
  }
}
