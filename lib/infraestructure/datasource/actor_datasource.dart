import 'package:cine_app/domain/datasources/actor_data.dart';
import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/infraestructure/models/moviebd/credist_response.dart';
import 'package:dio/dio.dart';
import 'package:cine_app/config/constants/env.dart';
import 'package:cine_app/infraestructure/mappers/actor_mapper.dart';

class ActorDatasource extends ActorData {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {"api_key": Env.apiKey, "language": "es-MX"},
    ),
  );

  @override
  Future<List<Actor>> getActorByMovieId({String? movieId}) async {
    final response = await dio.get("/movie/$movieId/credits");
    final castResponse = CastResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
