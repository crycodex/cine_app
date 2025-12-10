import 'package:cine_app/domain/entities/actor.dart';

abstract class ActorRepo {
  Future<List<Actor>> getActorByMovieId({String movieId});
}
