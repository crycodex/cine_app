import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/infraestructure/repositories/movie_repo_implementation.dart';
import 'package:cine_app/infraestructure/datasource/movie_datasource.dart';

//inmutable
// -> es inmutable porque no se puede modificar
final movieRepoProvider = Provider(
  (ref) => MovieRepoImplementation(dataSource: MovieDatasource()),
);
