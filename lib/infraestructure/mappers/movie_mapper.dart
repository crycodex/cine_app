import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/infraestructure/models/moviebd/movie_model.dart';
import 'package:cine_app/infraestructure/models/moviebd/movie_details.dart';

class MovieMapper {
  static Movie movieResponseToMovie(MovieModel movieResponse) => Movie(
    adult: movieResponse.adult,
    backdropPath: movieResponse.backdropPath != ""
        ? "https://image.tmdb.org/t/p/w500/${movieResponse.backdropPath}"
        : "https://marketplace.canva.com/EAEbNyW0c8A/1/0/1131w/canva-azul-tormenta-mar-pel%C3%ADcula-p%C3%B3ster-mFNHMKQlmUs.jpg",
    genreIds: movieResponse.genreIds.map((e) => e).toList(),
    id: movieResponse.id,
    originalLanguage: movieResponse.originalLanguage,
    originalTitle: movieResponse.originalTitle,
    overview: movieResponse.overview,
    popularity: movieResponse.popularity,
    posterPath: movieResponse.posterPath != ""
        ? "https://image.tmdb.org/t/p/w500/${movieResponse.posterPath}"
        : "https://marketplace.canva.com/EAEbNyW0c8A/1/0/1131w/canva-azul-tormenta-mar-pel%C3%ADcula-p%C3%B3ster-mFNHMKQlmUs.jpg",
    releaseDate: movieResponse.releaseDate != ""
        ? movieResponse.releaseDate
        : "No se ha encontrado la fecha de estreno",
    title: movieResponse.title,
    video: movieResponse.video,
    voteAverage: movieResponse.voteAverage,
    voteCount: movieResponse.voteCount,
  );

  static Movie movieDetailsToMovie(MovieDetails movieDetails) => Movie(
    adult: movieDetails.adult,
    backdropPath: (movieDetails.backdropPath != "")
        ? "https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}"
        : "https://marketplace.canva.com/EAEbNyW0c8A/1/0/1131w/canva-azul-tormenta-mar-pel%C3%ADcula-p%C3%B3ster-mFNHMKQlmUs.jpg",
    genreIds: movieDetails.genres.map((e) => e.id).toList(),
    id: movieDetails.id,
    originalLanguage: movieDetails.originalLanguage,
    originalTitle: movieDetails.originalTitle,
    overview: movieDetails.overview,
    popularity: movieDetails.popularity,
    posterPath: (movieDetails.posterPath != "")
        ? "https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}"
        : "https://marketplace.canva.com/EAEbNyW0c8A/1/0/1131w/canva-azul-tormenta-mar-pel%C3%ADcula-p%C3%B3ster-mFNHMKQlmUs.jpg",
    releaseDate: movieDetails.releaseDate != null
        ? movieDetails.releaseDate!.toString()
        : "No se ha encontrado la fecha de estreno",
    title: movieDetails.title,
    video: movieDetails.video,
    voteAverage: movieDetails.voteAverage,
    voteCount: movieDetails.voteCount,
  );
}
