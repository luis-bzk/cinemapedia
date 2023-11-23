import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieDetails(String id);
  Future<List<Movie>> searchMovies({String query, int page = 1});
}
