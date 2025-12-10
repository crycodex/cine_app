import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/repositories/movie_repo.dart';
import 'package:cine_app/domain/datasources/movie_data.dart';

class MovieRepoImplementation extends MovieRepo {
  final MovieData dataSource;

  MovieRepoImplementation({required this.dataSource});

  @override
  Future<List<Movie>> getNowPlayMovies({int page = 1}) async {
    return await dataSource.getNowPlayMovies(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    return await dataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    return await dataSource.getUpcomingMovies(page: page);
  }

  @override
  Future<Movie> getMovieById({String? id}) {
    return dataSource.getMovieById(id: id);
  }

  /* search */
  @override
  Future<List<Movie>> searchMovies({String query = ""}) async {
    return await dataSource.searchMovies(query);
  }
}
