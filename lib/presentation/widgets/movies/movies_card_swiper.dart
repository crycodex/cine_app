import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviesCardSwiper extends StatefulWidget {
  final List<Movie> movies;

  const MoviesCardSwiper({super.key, required this.movies});

  @override
  State<MoviesCardSwiper> createState() => _MoviesCardSwiperState();
}

class _MoviesCardSwiperState extends State<MoviesCardSwiper> {
  final SwiperController swiperController = SwiperController();
  bool isAutoplayEnabled = true;
  bool isUserInteracting = false;

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Swiper(
        controller: swiperController,
        loop: widget.movies.length > 1,
        autoplay: isAutoplayEnabled && widget.movies.length > 1,
        autoplayDelay: 4000,
        duration: 500,
        itemCount: widget.movies.length,
        itemWidth: MediaQuery.of(context).size.width * 0.8,
        layout: SwiperLayout.DEFAULT,
        viewportFraction: 0.8,
        scale: 0.9,
        onTap: (index) {
          context.push("/movie/${widget.movies[index].id}");
        },
        onIndexChanged: (index) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                isAutoplayEnabled = true;
              });
            }
          });
        },
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return GestureDetector(
            onTap: () => context.push("/movie/${movie.id}"),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.backdropPath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error_outline),
                        );
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 8,
                                    ),
                                  ],
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
            ),
          );
        },
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          builder: SwiperCustomPagination(
            builder: (context, config) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  config.itemCount,
                  (index) {
                    final isActive = index == config.activeIndex;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
