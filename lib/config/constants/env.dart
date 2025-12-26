import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class Env {
  static String get apiKey {
    // Primero intenta obtener desde --dart-define (más seguro para release)
    const String fromDefine = String.fromEnvironment('MOVIE_KEY');
    if (fromDefine.isNotEmpty) {
      return fromDefine;
    }
    // Si no está definido, usa el archivo .env
    final key = dotenv.env["MOVIE_KEY"] ?? "";
    if (key.isEmpty && kDebugMode) {
      debugPrint("Warning: MOVIE_KEY is empty. Check your .env file or use --dart-define.");
    }
    return key;
  }
}