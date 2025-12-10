import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class StoreUrlHelper {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;

  static String getStoreUrl({
    required String androidUrl,
    required String iosUrl,
  }) {
    if (isIOS) {
      return iosUrl;
    }
    return androidUrl;
  }

  static bool isAppAvailable({
    required String androidUrl,
    required String iosUrl,
  }) {
    if (isIOS) {
      return iosUrl.isNotEmpty;
    }
    return androidUrl.isNotEmpty;
  }

  static Future<void> openStoreUrl({
    required String androidUrl,
    required String iosUrl,
  }) async {
    try {
      final url = getStoreUrl(
        androidUrl: androidUrl,
        iosUrl: iosUrl,
      );
      if (url.isEmpty) return;
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Si hay un error, intentar con la URL de Android (Play Store) por defecto
      if (androidUrl.isNotEmpty) {
        try {
          final uri = Uri.parse(androidUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } catch (_) {
          // Error al abrir la URL
        }
      }
    }
  }
}

