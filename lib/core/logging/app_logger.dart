import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static late final Logger l;

  static void init() {
    l = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        noBoxingByDefault: true,
      ),
      level: kReleaseMode ? Level.off : Level.debug,
    );
  }
}
