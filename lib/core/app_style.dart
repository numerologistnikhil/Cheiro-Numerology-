import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'root_profiles.dart' show L;

/// Which numerology tradition the customer prefers.
enum NumerologyStyle { chaldean, western, both }

/// First-run choices: numerology style and whether the setup was finished.
class AppStyle extends ChangeNotifier {
  AppStyle._();
  static final AppStyle instance = AppStyle._();

  static const String _kStyle = 'numerology_style';
  static const String _kDone = 'setup_done';

  NumerologyStyle _style = NumerologyStyle.both;
  bool _done = false;

  NumerologyStyle get style => _style;
  bool get setupDone => _done;

  /// Western (Pythagorean) parts are shown for Western or Both.
  bool get showWestern => _style != NumerologyStyle.chaldean;

  Future<void> load() async {
    try {
      final p = await SharedPreferences.getInstance();
      final s = p.getString(_kStyle);
      _style = NumerologyStyle.values.firstWhere(
        (e) => e.name == s,
        orElse: () => NumerologyStyle.both,
      );
      _done = p.getBool(_kDone) ?? false;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setStyle(NumerologyStyle v) async {
    _style = v;
    notifyListeners();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_kStyle, v.name);
    } catch (_) {}
  }

  Future<void> finishSetup() async {
    _done = true;
    notifyListeners();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setBool(_kDone, true);
    } catch (_) {}
  }

  /// Home tiles that depend on the chosen style.
  bool showsTile(String key) => key != 'western' || showWestern;
}

class StyleTexts {
  static const L title = L('Numerology style', 'अंकशास्त्र की पद्धति');
  static const L intro = L(
    'Choose the tradition you like. You can change it any time in Settings.',
    'अपनी पसंद की पद्धति चुनिए। इसे कभी भी सेटिंग्स में बदल सकते हैं।');
  static const Map<NumerologyStyle, L> names = {
    NumerologyStyle.chaldean: L('Indian (Chaldean / Vedic)', 'भारतीय (कैल्डियन / वैदिक)'),
    NumerologyStyle.western: L('Western (Pythagorean)', 'पश्चिमी (पाइथागोरस)'),
    NumerologyStyle.both: L('Both together', 'दोनों साथ में'),
  };
  static const Map<NumerologyStyle, L> notes = {
    NumerologyStyle.chaldean: L('Mulank, Bhagyank, Lo Shu, lucky numbers, gemstones and rudraksha.',
        'मूलांक, भाग्यांक, लो शू, शुभ अंक, रत्न और रुद्राक्ष।'),
    NumerologyStyle.western: L('Life Path, Expression, Soul Urge, Personality, master numbers.',
        'लाइफ पाथ, एक्सप्रेशन, सोल अर्ज, पर्सनैलिटी, मास्टर अंक।'),
    NumerologyStyle.both: L('Everything, so you can compare the two readings.',
        'सब कुछ, ताकि आप दोनों पाठों की तुलना कर सकें।'),
  };
}
