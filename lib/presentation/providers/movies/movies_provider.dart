import 'package:flutter_riverpod/legacy.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/movies/movie_repo.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepoProvider).getNowPlayMovies;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepoProvider).getPopularMovies;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepoProvider).getUpcomingMovies;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final categoriesMoviesProvider =
    StateNotifierProvider<CategoriesMoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepoProvider).getUpcomingMovies;

      return CategoriesMoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

//callback -> es una funcion que se pasa como parametro a otra funcion
//typedef -> es un alias para un tipo de dato
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoading = false;
  static const int maxMovies = 10;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    final newState = [...state, ...movies];

    if (newState.length >= maxMovies) {
      state = newState.skip(newState.length - maxMovies).toList();
    } else {
      state = newState;
    }
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  //mas recientes
  List<Movie> get recentMovies => state.take(10).toList();
}

class CategoriesMoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoading = false;
  bool hasReachedEnd = false;

  CategoriesMoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading || hasReachedEnd) return;
    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    if (movies.isEmpty) {
      hasReachedEnd = true;
      isLoading = false;
      return;
    }

    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  void reset() {
    currentPage = 0;
    hasReachedEnd = false;
    state = [];
  }
}
