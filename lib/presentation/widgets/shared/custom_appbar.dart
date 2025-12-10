import 'package:flutter/material.dart';
import 'package:cine_app/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/providers/theme/theme_provider.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 65,
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      builder: (context) =>
                          _buildMenuSheet(context, theme, ref),
                    );
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  tooltip: "Menú",
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Icon(
                      Icons.movie_outlined,
                      size: 28,
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Cine App",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    final searchQuery = ref.read(searchQueryProvider);
                    final searchedMovies = ref.read(searchedMoviesProvider);

                    await showSearch<Movie?>(
                      context: context,
                      query: searchQuery,
                      delegate: SearchMovieDelegate(
                        initialMovies: searchedMovies,
                        searchMovies: ref
                            .read(searchedMoviesProvider.notifier)
                            .searchMoviesQuery,
                      ),
                    ).then(
                      (movie) => movie != null
                          ? context.push("/movie/${movie.id}")
                          : null,
                    );
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  tooltip: "Buscar",
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == AppThemeMode.dark;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: theme.colorScheme.primary,
          size: 24,
        ),
      ),
      title: Text(
        "Tema",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        isDarkMode ? "Modo oscuro" : "Modo claro",
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          ref.read(themeProvider.notifier).toggleTheme();
        },
        activeColor: theme.colorScheme.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  Widget _buildMenuSheet(BuildContext context, ThemeData theme, WidgetRef ref) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final bottomNavHeight = 60.0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding + bottomNavHeight),
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _buildThemeSwitch(context, theme, ref),
              _buildMenuTile(
                context,
                theme,
                Icons.info_outline,
                "Créditos",
                "Información del desarrollador",
                () {
                  Navigator.pop(context);
                  context.push("/credits");
                },
              ),
              _buildMenuTile(
                context,
                theme,
                Icons.close,
                "Cerrar",
                "",
                () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            )
          : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}
