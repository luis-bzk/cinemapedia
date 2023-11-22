import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/dataSources/actor_data_source_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(dataSource: ActorMovieDbDataSource());
});
