import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/config/helpers/numformat.dart';
import 'package:animate_do/animate_do.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies = [];

  //debounce -> delay -> espera a que el usuario deje de escribir
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounce;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies})
    : super(
        searchFieldLabel: "Busca tu pelicula",
        textInputAction: TextInputAction.search,
      );

  void _onQueryChanged(String query) {
    isLoading.add(true);
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debounceMovies.add(movies);
      isLoading.add(false);
    });
  }

  @override
  String get searchFieldLabel => "Busca tu pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    debugPrint(query);
    if (query.isEmpty) return null;
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(milliseconds: 500),
              spins: 10,
              infinite: query.isNotEmpty,
              child: IconButton(
                onPressed: () => query = "",
                icon: const Icon(Icons.refresh),
              ),
            );
          }
          return IconButton(
            onPressed: () {
              query = "";
              _onQueryChanged(query);
            },
            icon: const Icon(Icons.clear),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => {close(context, null)},
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieItem(
              movie: movie,
              movieSelected: (context, movie) {
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie) movieSelected;

  const MovieItem({
    super.key,
    required this.movie,
    required this.movieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => movieSelected(context, movie),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            /* poster */
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(movie.posterPath),
                width: size.width * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            /* title and overview */
            SizedBox(
              width: (size.width - 80) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* title */
                  Text(movie.title, style: textStyles.titleMedium),
                  /* overview */
                  (movie.overview.length > 100)
                      ? Text("${movie.overview.substring(0, 100)}...")
                      : Text(movie.overview),
                  /* rating */
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade700,
                      ),
                      Text(
                        Numformat.number(movie.popularity),
                        style: textStyles.bodySmall?.copyWith(
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
