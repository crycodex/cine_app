import 'package:flutter/material.dart';
import 'package:cine_app/config/theme/app_theme.dart';
import 'package:cine_app/config/routes/routes.dart';
import 'package:cine_app/presentation/providers/theme/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == AppThemeMode.dark;
    final appTheme = AppTheme();

    return MaterialApp.router(
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(isDarkMode: false),
      darkTheme: appTheme.getTheme(isDarkMode: true),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      title: "Cine App",
    );
  }
}
