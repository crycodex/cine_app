import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            iconSize: 26,
            items: [
              BottomNavigationBarItem(
                icon: _AnimatedIcon(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  isActive: currentIndex == 0,
                  color: theme.colorScheme.primary,
                ),
                label: "Inicio",
              ),
              BottomNavigationBarItem(
                icon: _AnimatedIcon(
                  icon: Icons.shuffle_rounded,
                  activeIcon: Icons.shuffle_rounded,
                  isActive: currentIndex == 1,
                  color: theme.colorScheme.primary,
                ),
                label: "Aleatorias",
              ),
              BottomNavigationBarItem(
                icon: _AnimatedIcon(
                  icon: Icons.favorite_outline,
                  activeIcon: Icons.favorite_rounded,
                  isActive: currentIndex == 2,
                  color: theme.colorScheme.primary,
                ),
                label: "Favoritos",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final Color color;

  const _AnimatedIcon({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Icon(
        isActive ? activeIcon : icon,
        key: ValueKey(isActive),
        color: isActive ? color : null,
      ),
    );
  }
}
