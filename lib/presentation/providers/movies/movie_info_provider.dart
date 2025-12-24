import 'package:flutter_riverpod/legacy.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/movies/movie_repo.dart';
import 'package:flutter/foundation.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final movieRepo = ref.watch(movieRepoProvider);

      return MovieMapNotifier(
        getMovie: (String movieId) => movieRepo.getMovieById(id: movieId),
      );
    });

typedef MovieInfoCalBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final MovieInfoCalBack getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    debugPrint("loading movie $movieId");

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
