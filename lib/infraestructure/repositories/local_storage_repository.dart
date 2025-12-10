import 'package:cine_app/domain/repositories/local_storage_repository.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/datasources/local_storage_datasource.dart';

class LocalStorageRepositoryImp extends LocalStorageRepository {
  final LocalStorageDatasource? datasource;

  LocalStorageRepositoryImp({this.datasource});

  @override
  Future<void> toggleFavorites(Movie movie) async {
    return datasource?.toggleFavorites(movie) ?? Future.value();
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    return datasource?.isFavoriteMovie(movieId) ?? false;
  }

  @override
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0}) async {
    return datasource?.getFavorites(limit: limit, offset: offset) ?? [];
  }
}
