import 'package:flutter/material.dart';
import 'package:cine_app/config/theme/app_theme.dart';
import 'package:cine_app/config/routes/routes.dart';
import 'package:cine_app/presentation/providers/theme/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // En release, el archivo .env se carga desde assets del bundle
    // dotenv.load() busca el archivo en assets cuando está en pubspec.yaml
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Si falla con el nombre específico, intenta cargar sin especificar
    try {
      await dotenv.load();
    } catch (e2) {
      // Si todo falla, muestra warning pero continúa
      debugPrint("Warning: Could not load .env file: $e2");
      debugPrint(
        "The app may not work correctly without environment variables.",
      );
    }
  }

  // Verificar que la API key esté cargada
  final apiKey = dotenv.env["MOVIE_KEY"] ?? "";
  if (apiKey.isEmpty) {
    debugPrint("⚠️ Warning: MOVIE_KEY is not set in .env file");
  } else {
    debugPrint("✅ MOVIE_KEY loaded successfully (length: ${apiKey.length})");
  }

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
