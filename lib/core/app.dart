import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class CheiroApp extends StatelessWidget {
  const CheiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheiro Numerology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB8860B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F5EF),
          foregroundColor: Color(0xFF171717),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
