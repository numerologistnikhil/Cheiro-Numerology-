import 'package:flutter/material.dart';
import 'core/app.dart';
import 'core/app_settings.dart';
import 'core/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.instance.load();
  await AppThemeStore.instance.load();
  runApp(const CheiroApp());
}
