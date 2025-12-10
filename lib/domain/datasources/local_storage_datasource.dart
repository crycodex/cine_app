import 'package:cine_app/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorites(Movie movie);

  Future<bool> isFavoriteMovie(int movieId);

  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0});
}
