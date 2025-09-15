import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static Future<void> initialize({String fileName = '.env'}) async {
    if (!dotenv.isInitialized) {
      await dotenv.load(fileName: fileName);
    }
  }

  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
}
