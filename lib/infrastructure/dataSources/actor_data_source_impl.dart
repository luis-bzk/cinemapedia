import 'package:dio/dio.dart';

import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/infrastructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/domain/dataSources/actors_data_source.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDataSource extends ActorsDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-EC'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('Movie with ID: $movieId, do not have actors');
    }

    final movieCast = CreditsResponse.fromJson(response.data);
    final List<Actor> actors =
        movieCast.cast.map((actor) => ActorMapper.castToEntity(actor)).toList();
    return actors;
  }
}
