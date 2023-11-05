import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/domain/dataSources/movies_data_source.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

class MovieDbDataSource extends MoviesDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-EC',
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final reponse = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];
    return movies;
  }
}
