import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMansory extends StatefulWidget {
  final List<Movie> movies;
  final Future<List<Movie>> Function()? loadMoreMovies;

  const MovieMansory({super.key, required this.movies, this.loadMoreMovies});

  @override
  State<MovieMansory> createState() => _MovieMansoryState();
}

class _MovieMansoryState extends State<MovieMansory> {
  bool isLastPage = false;
  bool isLoading = false;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadMoreMovies == null) return;
      if (scrollController.position.pixels + 100 >=
          scrollController.position.maxScrollExtent) {
        loadNextPageMovies();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void loadNextPageMovies() async {
    if (isLoading || isLastPage) return;
    if (widget.loadMoreMovies == null) return;

    isLoading = true;
    final newMovies = await widget.loadMoreMovies!();
    isLoading = false;

    if (newMovies.isEmpty) {
      isLastPage = true;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                SizedBox(height: 35),
                MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
