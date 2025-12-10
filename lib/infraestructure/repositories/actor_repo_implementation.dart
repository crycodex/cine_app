import 'package:cine_app/domain/datasources/actor_data.dart';
import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/domain/repositories/actor_repo.dart';

class ActorRepoImplementation extends ActorRepo{

  final ActorData datasource;
  ActorRepoImplementation({required this.datasource});

  @override
  Future<List<Actor>> getActorByMovieId({String? movieId}) async {
    return await datasource.getActorByMovieId(movieId: movieId ?? "");
  }
}