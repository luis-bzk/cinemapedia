import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/dataSources/movies_data_source.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return dataSource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }
}
