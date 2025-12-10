import 'package:flutter/material.dart';

class ScreenLoader extends StatelessWidget {
  ScreenLoader({super.key});

  final msgs = [
    'Abriendo la puerta...',
    'Cargando las películas...',
    'Comprando los tickets...',
    'Disfrutando de la película...',
    'Esto está tardando más de lo esperado :) ...',
  ];

  Stream<String> getMsgs() {
    return Stream.periodic(const Duration(seconds: 2), (step) {
      return msgs[step % msgs.length];
    }).take(msgs.length);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: getMsgs(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                return Text(
                  snapshot.data!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
