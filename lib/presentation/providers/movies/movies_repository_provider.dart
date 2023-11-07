import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/infrastructure/dataSources/moviedb_data_source_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(dataSource: MovieDbDataSourceImpl());
});
