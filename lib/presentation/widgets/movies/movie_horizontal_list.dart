import 'package:flutter/material.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/config/helpers/numformat.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalList extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalList({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalList> createState() => _MovieHorizontalListState();
}

class _MovieHorizontalListState extends State<MovieHorizontalList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                widget.subtitle ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 260, // Altura fija para el ListView horizontal
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _SlideMovie(movie: widget.movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {
  final Movie movie;

  const _SlideMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return GestureDetector(
                      onTap: () {
                        context.push("/movie/${movie.id}");
                      },
                      child: child,
                    );
                  }
                },
              ),
            ),
          ),
          //title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          //rating
          Row(
            children: [
              Icon(Icons.star_half_rounded, color: Colors.yellow),
              Text(
                Numformat.number(movie.voteAverage),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "(${Numformat.numerlarge(movie.voteCount.toDouble())})",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
