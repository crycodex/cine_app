import 'package:cine_app/domain/datasources/local_storage_datasource.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/config/database/database.dart';
import 'package:drift/drift.dart';

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<void> toggleFavorites(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoritesMovies)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteQuery.go();
      return;
    }

    await database
        .into(database.favoritesMovies)
        .insert(
          FavoritesMoviesCompanion.insert(
            movieId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: Value<double>(movie.voteAverage),
          ),
        );
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final query = database.select(database.favoritesMovies)
      ..where((table) => table.movieId.equals(movieId));

    final result = await query.getSingleOrNull();

    return result != null;
  }

  @override
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0}) async {
    final query = database.select(database.favoritesMovies)
      ..limit(limit, offset: offset);

    final result = await query.get();

    final movies = result
        .map(
          (row) => Movie(
            adult: false,
            backdropPath: row.backdropPath,
            genreIds: const [],
            id: row.movieId,
            originalLanguage: "",
            originalTitle: row.originalTitle,
            overview: "",
            popularity: 0,
            posterPath: row.posterPath,
            releaseDate: "",
            title: row.title,
            video: false,
            voteAverage: row.voteAverage,
            voteCount: 0,
          ),
        )
        .toList();

    return movies;
  }
}
