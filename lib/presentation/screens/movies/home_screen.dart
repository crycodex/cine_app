import 'package:flutter/material.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home-screen";

  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  void onNavigationShell(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  bool _shouldBottom(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return !location.contains('/movie/');
  }

  @override
  Widget build(BuildContext context) {
    final shouldBottom = _shouldBottom(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: shouldBottom
          ? CustomBottomNavigation(
              currentIndex: navigationShell.currentIndex,
              onTap: onNavigationShell,
            )
          : const SizedBox.shrink(),
    );
  }
}
