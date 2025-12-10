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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.loadMoreMovies == null) return;
    if (isLoading || isLastPage) return;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final threshold = maxScroll * 0.8;

    if (currentScroll >= threshold && maxScroll > 0) {
      loadNextPageMovies();
    }
  }

  Future<void> loadNextPageMovies() async {
    if (isLoading || isLastPage) return;
    if (widget.loadMoreMovies == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final previousLength = widget.movies.length;
      final allMovies = await widget.loadMoreMovies!();

      if (mounted) {
        setState(() {
          isLoading = false;
          if (allMovies.isEmpty || allMovies.length == previousLength) {
            isLastPage = true;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
