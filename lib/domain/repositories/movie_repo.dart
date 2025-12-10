import 'package:cine_app/domain/entities/movie.dart';

abstract class MovieRepo {
  Future<List<Movie>> getNowPlayMovies({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getUpcomingMovies({int page = 1});

  Future<Movie> getMovieById({String? id});

  /* search */
  Future<List<Movie>> searchMovies({String query});
}
