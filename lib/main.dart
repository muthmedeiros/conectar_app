import 'package:flutter/material.dart';

import 'app.dart';
import 'config/app_config.dart';

Future<void> main() async {
  await AppConfig.initialize();

  runApp(const ConectarApp());
}
