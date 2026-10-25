import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import 'app_settings.dart';

class AnkdharaColors {
  static const pearl = Color(0xFFFBF8F1);
  static const cream = Color(0xFFF5EEDC);
  static const gold = Color(0xFFB8860B);
  static const goldLight = Color(0xFFD4AF37);
  static const ink = Color(0xFF2B2418);
  static const goldLine = Color(0x55B8860B);
}

class CheiroApp extends StatelessWidget {
  const CheiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AnkdharaColors.gold,
      brightness: Brightness.light,
    ).copyWith(
      primary: AnkdharaColors.gold,
      onPrimary: Colors.white,
      secondary: AnkdharaColors.goldLight,
      surface: AnkdharaColors.pearl,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
    );

    final text = base.textTheme
        .apply(
          bodyColor: AnkdharaColors.ink,
          displayColor: AnkdharaColors.ink,
        )
        .copyWith(
          headlineMedium: base.textTheme.headlineMedium?.copyWith(
            fontFamily: 'serif',
            fontWeight: FontWeight.w700,
            color: AnkdharaColors.ink,
          ),
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontFamily: 'serif',
            fontWeight: FontWeight.w700,
            color: AnkdharaColors.ink,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontFamily: 'serif',
            fontWeight: FontWeight.w600,
            color: AnkdharaColors.ink,
          ),
        );

    return AppLang(
      settings: AppSettings.instance,
      child: MaterialApp(
        title: 'Ank Dhara',
        debugShowCheckedModeBanner: false,
        theme: base.copyWith(
          textTheme: text,
          scaffoldBackgroundColor: AnkdharaColors.pearl,
          appBarTheme: AppBarTheme(
            backgroundColor: AnkdharaColors.pearl,
            foregroundColor: AnkdharaColors.ink,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              fontFamily: 'serif',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AnkdharaColors.ink,
            ),
          ),
          cardTheme: const CardThemeData(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              side: BorderSide(color: AnkdharaColors.goldLine),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: AnkdharaColors.gold,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AnkdharaColors.goldLine),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AnkdharaColors.goldLine),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: AnkdharaColors.gold, width: 1.6),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
