import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_app/presentation/screens/screens.dart';
import 'package:cine_app/presentation/views/views.dart';
import 'package:cine_app/presentation/screens/about/credits_screen.dart';

final GlobalKey<NavigatorState> _homeNavigatorState = GlobalKey<NavigatorState>(
  debugLabel: "homeNavigator",
);
final GlobalKey<NavigatorState> _categoriesState = GlobalKey<NavigatorState>(
  debugLabel: "categoriesNavigator",
);
final GlobalKey<NavigatorState> _favoritesState = GlobalKey<NavigatorState>(
  debugLabel: "favoritesNavigator",
);

final appRoutes = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorState,
          routes: [
            GoRoute(
              path: "/",
              name: HomeView.name,
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: "/movie/:id",
                  name: MovieScreen.name,
                  builder: (context, state) =>
                      MovieScreen(movieId: state.pathParameters["id"] ?? ""),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _categoriesState,
          routes: [
            GoRoute(
              path: "/categories",
              name: CategoriesView.name,
              builder: (context, state) => const CategoriesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _favoritesState,
          routes: [
            GoRoute(
              path: "/favorites",
              name: FavoritesView.name,
              builder: (context, state) => const FavoritesView(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/credits",
      name: CreditsScreen.name,
      builder: (context, state) => const CreditsScreen(),
    ),

    //ruta padre e hijo
    /* 
     GoRoute(
      path: "/",
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(childView: HomeView()),
    ),
    GoRoute(
      path: "/movie/:id",
      name: MovieScreen.name,
      builder: (context, state) =>
          MovieScreen(movieId: state.pathParameters["id"] ?? ""),
    ),
     */
  ],
);
