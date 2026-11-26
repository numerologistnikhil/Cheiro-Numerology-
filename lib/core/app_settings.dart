import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'root_profiles.dart';
import 'translations.dart';

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
    AppLanguage('es', 'Spanish', 'Español', false),
    AppLanguage('fr', 'French', 'Français', false),
    AppLanguage('de', 'German', 'Deutsch', false),
    AppLanguage('pt', 'Portuguese', 'Português', false),
    AppLanguage('ru', 'Russian', 'Русский', false),
    AppLanguage('ar', 'Arabic', 'العربية', false),
    AppLanguage('bn', 'Bengali', 'বাংলা', false),
    AppLanguage('id', 'Indonesian', 'Bahasa Indonesia', false),
    AppLanguage('zh', 'Chinese', '中文', false),
    AppLanguage('ja', 'Japanese', '日本語', false),
  ];

  /// Languages written from right to left.
  static const Set<String> rightToLeft = {'ar'};
}

/// App-wide settings. For now: the app language (English or Hindi).
class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  static const String _kHindi = 'app_hindi';
  static const String _kLang = 'app_lang';
  String _code = 'en';
  bool _hindi = false;

  /// The chosen language code, such as en, hi, es, ar.
  String get code => _code;

  /// True only for Hindi. The long texts and the report exist in English and
  /// Hindi; every other language falls back to English there.
  bool get hindi => _hindi;

  bool get rtl => AppLanguages.rightToLeft.contains(_code);

  static const String _kSound = 'app_sound';
  bool _sound = true;

  /// Tap sounds ON (default) or OFF.
  bool get sound => _sound;

  Future<void> setSound(bool v) async {
    if (v == _sound) return;
    _sound = v;
    notifyListeners();
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kSound, v);
  }

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final saved = p.getString(_kLang) ??
        ((p.getBool(_kHindi) ?? false) ? 'hi' : 'en');
    final code = AppLanguages.all.any((l) => l.code == saved) ? saved : 'en';
    final snd = p.getBool(_kSound) ?? true;
    if (code != _code || snd != _sound) {
      _code = code;
      _hindi = code == 'hi';
      _sound = snd;
      notifyListeners();
    }
  }

  Future<void> setHindi(bool v) => setLanguage(v ? 'hi' : 'en');

  Future<void> setLanguage(String code) async {
    if (code == _code) return;
    _code = code;
    _hindi = code == 'hi';
    notifyListeners();
    final p = await SharedPreferences.getInstance();
    await p.setString(_kLang, code);
    await p.setBool(_kHindi, _hindi);
  }

  /// Picks the text for the chosen language. Hindi and English come from the
  /// text itself; other languages come from the translation list and fall
  /// back to English.
  String t(L l) {
    if (_code == 'hi') return l.hi;
    if (_code == 'en') return l.en;
    return Translations.lookup(_code, l.en) ?? l.en;
  }
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
