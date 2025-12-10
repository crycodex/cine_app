import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/infraestructure/models/moviebd/credist_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) =>
  Actor(
    id: cast.id,
    name: cast.name,
    character: cast.character ?? "",
    profilePath: cast.profilePath != null
    ? "https://image.tmdb.org/t/p/w500/${cast.profilePath}"
    : "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
  );
}