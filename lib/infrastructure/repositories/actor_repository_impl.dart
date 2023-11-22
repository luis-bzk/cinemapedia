import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/domain/dataSources/actors_data_source.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;
  ActorsRepositoryImpl({required this.dataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
