import 'package:cine_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/config/helpers/genre_helper.dart';
/* Providers */
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/providers/storage/is_favorite_movie_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = "movie-screen";

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _SliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _SliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isfavorite = ref.watch(isFavoriteMovieProvider(movie.id));

    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      /* actions */
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavoriteMovie(movie);
            ref.invalidate(isFavoriteMovieProvider(movie.id));
          },
          icon: isfavorite.when(
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_outline, color: Colors.white),
            error: (error, stackTrace) => Icon(Icons.error, color: Colors.red),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.7, 0.95],
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            /* sombra corazon */
            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.4],
              colors: [Colors.transparent, Colors.black54],
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              /* Descripcion */
              SizedBox(
                width: (size.width - 80) * 0.7,
                child: Column(
                  children: [
                    Text(movie.title, style: textStyles.headlineSmall),
                    Text(movie.overview, style: textStyles.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        /* Generos */
        Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (genreId) => Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Chip(label: Text(getGenreName(genreId))),
                ),
              ),
            ],
          ),
        ),
        /* Actores */
        _ActorsList(movieId: movie.id.toString()),
      ],
    );
  }
}

class _ActorsList extends ConsumerWidget {
  final String movieId;

  const _ActorsList({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actors = ref.watch(actorsByMovieProvider)[movieId.toString()];
    final textStyles = Theme.of(context).textTheme;

    if (actors == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final actorsList = actors;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsList.length,
        itemBuilder: (context, index) {
          final actor = actorsList[index];

          return Container(
            padding: const EdgeInsets.all(10),
            width: 120,
            child: Column(
              children: [
                /* foto */
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    actor.profilePath,
                    width: 200,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  actor.name,
                  style: textStyles.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  actor.character ?? "",
                  style: textStyles.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
