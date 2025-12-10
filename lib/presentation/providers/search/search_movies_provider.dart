import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/movies/movie_repo.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.read(movieRepoProvider);

      return SearchedMoviesNotifier(
        searchMovies: (query) => movieRepository.searchMovies(query: query),
        ref: ref,
      );
    });

//typedef -> es un alias para un tipo de dato
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
    : super([]);

  Future<List<Movie>> searchMoviesQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
