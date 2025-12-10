import 'package:cine_app/presentation/widgets/movies/movie_mansory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/providers/providers.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static const String name = "categories-view";

  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final movies = ref.watch(categoriesMoviesProvider);

    if (movies.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(categoriesMoviesProvider.notifier).loadNextPage();
        }
      });
      final theme = Theme.of(context);
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Cargando películas...",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          MovieMansory(
            movies: movies,
            loadMoreMovies: () async {
              await ref.read(categoriesMoviesProvider.notifier).loadNextPage();
              return ref.read(categoriesMoviesProvider);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swipe_up_alt, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Desliza para randomizar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
