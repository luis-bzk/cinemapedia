import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final fetchActors = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: fetchActors.getActorsByMovie);
});

typedef GetMovieActors = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetMovieActors getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loasActors(String movieID) async {
    if (state[movieID] != null) return;
    final List<Actor> actors = await getActors(movieID);

    state = {...state, movieID: actors};
  }
}
