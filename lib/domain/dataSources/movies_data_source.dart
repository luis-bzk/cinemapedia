import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
