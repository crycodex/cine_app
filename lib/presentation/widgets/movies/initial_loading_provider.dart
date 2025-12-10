import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/providers/movies/movies_provider.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;

  if(nowPlayingMovies && popularMovies && upcomingMovies) {
    return true;
  }

  return false;
});
