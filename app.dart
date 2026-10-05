import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class CheiroApp extends StatelessWidget {
  const CheiroApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Cheiro Numerology',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: const Color(0xFFD4AF37), scaffoldBackgroundColor: const Color(0xFF070A12)),
    home: const HomeScreen(),
  );
}
