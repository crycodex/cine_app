import 'package:flutter_riverpod/legacy.dart';
import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter/foundation.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorRepo = ref.watch(actorRepoProvider);

      return ActorsByMovieNotifier(
        getActors: (String movieId) =>
            actorRepo.getActorByMovieId(movieId: movieId),
      );
    });

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    debugPrint("loading actors for movie $movieId");
    debugPrint("getActors: ${await getActors(movieId)}");

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
