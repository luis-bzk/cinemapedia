import 'package:cinemapedia/domain/entities/actor_entity.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
