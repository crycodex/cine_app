import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/repositories/local_storage_repository.dart';
import 'package:cine_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

final favoriteMoviesProvider = StateNotifierProvider((ref) {
  final LocalStorageRepository localStorageRepository = ref.watch(
    localStorageRepositoryProvider,
  );
  return StorageMovieNotifier(
    {},
    localStorageRepository: localStorageRepository,
  );
});

class StorageMovieNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;

  final LocalStorageRepository localStorageRepository;

  StorageMovieNotifier(super.state, {required this.localStorageRepository});

  Future<List<Movie>> loadFavorites() async {
    final movies = await localStorageRepository.getFavorites(
      limit: 10,
      offset: page * 10,
    );

    page++;

    final tempMovies = <int, Movie>{};

    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};
    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);
    debugPrint("isFavorite: $isFavorite");
    debugPrint("movie: ${movie.id}");
    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
      await localStorageRepository.toggleFavorites(movie);
      return;
    } else {
      state = {...state, movie.id: movie};
      await localStorageRepository.toggleFavorites(movie);
      return;
    }
  }
}
