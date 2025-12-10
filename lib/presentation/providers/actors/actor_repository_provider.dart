import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/infraestructure/repositories/actor_repo_implementation.dart';
import 'package:cine_app/infraestructure/datasource/actor_datasource.dart';

final actorRepoProvider = Provider(
  (ref) => ActorRepoImplementation(datasource: ActorDatasource()),
);
