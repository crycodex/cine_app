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

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
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
