import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'root_profiles.dart';

/// One language the customer can choose. New languages are added to
/// [AppLanguages.all]; the settings list shows them automatically.
class AppLanguage {
  final String code;
  final String english;
  final String native;
  final bool hindi; // today the app has two text sets: English and Hindi
  const AppLanguage(this.code, this.english, this.native, this.hindi);
}

class AppLanguages {
  static const List<AppLanguage> all = [
    AppLanguage('en', 'English', 'English', false),
    AppLanguage('hi', 'Hindi', 'हिन्दी', true),
  ];
}

/// App-wide settings. For now: the app language (English or Hindi).
class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  static const String _kHindi = 'app_hindi';
  bool _hindi = false;

  bool get hindi => _hindi;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final v = p.getBool(_kHindi) ?? false;
    if (v != _hindi) {
      _hindi = v;
      notifyListeners();
    }
  }

  Future<void> setHindi(bool v) async {
    if (v == _hindi) return;
    _hindi = v;
    notifyListeners();
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kHindi, v);
  }

  /// Picks the English or Hindi text.
  String t(L l) => _hindi ? l.hi : l.en;
}

/// Makes the language available to every screen. A screen that calls
/// AppLang.of(context) is rebuilt automatically when the language changes.
class AppLang extends InheritedNotifier<AppSettings> {
  const AppLang({
    Key? key,
    required AppSettings settings,
    required Widget child,
  }) : super(key: key, notifier: settings, child: child);

  static AppSettings of(BuildContext context) {
    final w = context.dependOnInheritedWidgetOfExactType<AppLang>();
    return w?.notifier ?? AppSettings.instance;
  }
}
