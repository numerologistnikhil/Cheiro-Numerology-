import 'package:flutter/material.dart';
import 'core/app.dart';
import 'core/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.instance.load();
  runApp(const CheiroApp());
}
