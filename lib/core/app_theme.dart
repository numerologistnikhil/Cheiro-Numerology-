import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'root_profiles.dart' show L;

/// One colour theme the customer can choose in Settings.
class AppThemeOption {
  final String id;
  final L name;
  final Color color; // the colour that replaces the app's main gold
  final Color tint; // the very light colour that replaces white backgrounds
  final bool premiumOnly; // false for now: every theme is free

  const AppThemeOption(
    this.id,
    this.name,
    this.color,
    this.tint, {
    this.premiumOnly = false,
  });
}

/// The ten themes. The whole app is drawn in white and gold; a theme turns the
/// gold into another colour. White and grey stay exactly as they are.
class AppThemes {
  static const Color baseGold = Color(0xFFB8860B);

  static const List<AppThemeOption> all = [
    AppThemeOption('pearl_gold', L('Pearl Gold', 'पर्ल गोल्ड'), Color(0xFFB8860B), Color(0xFFFFFFFF)),
    AppThemeOption('royal_blue', L('Royal Blue', 'रॉयल ब्लू'), Color(0xFF1F4FA3), Color(0xFFEAF1FF)),
    AppThemeOption('emerald', L('Emerald', 'एमरल्ड'), Color(0xFF0B7A5A), Color(0xFFE9F7F0)),
    AppThemeOption('burgundy', L('Royal Burgundy', 'रॉयल बरगंडी'), Color(0xFF7B1E3A), Color(0xFFFCEFF3)),
    AppThemeOption('platinum', L('Platinum', 'प्लैटिनम'), Color(0xFF5F6B7A), Color(0xFFEFF1F5)),
    AppThemeOption('lavender', L('Lavender', 'लैवेंडर'), Color(0xFF7E5BB5), Color(0xFFF3EEFC)),
    AppThemeOption('turquoise', L('Turquoise', 'फ़िरोज़ी'), Color(0xFF0E8C8C), Color(0xFFE6F8F8)),
    AppThemeOption('rose_gold', L('Rose Gold', 'रोज़ गोल्ड'), Color(0xFFB76E79), Color(0xFFFDEFF0)),
    AppThemeOption('ivory_bronze', L('Ivory Bronze', 'आइवरी ब्रॉन्ज़'), Color(0xFF8C5A2B), Color(0xFFFBF9F4)),
    AppThemeOption('midnight_indigo', L('Midnight Indigo', 'मिडनाइट इंडिगो'), Color(0xFF2E3A87), Color(0xFFECEEFB)),
  ];

  static AppThemeOption byId(String? id) {
    for (final t in all) {
      if (t.id == id) return t;
    }
    return all.first;
  }

  static double _r(Color c) => ((c.value >> 16) & 0xFF).toDouble();
  static double _g(Color c) => ((c.value >> 8) & 0xFF).toDouble();
  static double _b(Color c) => (c.value & 0xFF).toDouble();

  /// 3x3 colour matrix (row by row) for a theme. It turns the app's gold into
  /// the theme colour, white backgrounds into the theme's light tint, and
  /// leaves black as it is.
  /// Built in two steps: (1) identity + (target - gold) * w, where w ignores
  /// greys, so white and black are kept; (2) every channel is scaled so that
  /// white becomes the tint. Step 1 aims slightly higher so that after step 2
  /// the gold lands exactly on the theme colour.
  static List<double> matrix3(AppThemeOption o) {
    final g = [_r(baseGold), _g(baseGold), _b(baseGold)];
    final acc = [_r(o.color), _g(o.color), _b(o.color)];
    final tn = [_r(o.tint) / 255, _g(o.tint) / 255, _b(o.tint) / 255];
    final t = [
      for (var i = 0; i < 3; i++) (acc[i] / tn[i]).clamp(0.0, 255.0).toDouble(),
    ];
    final mean = (g[0] + g[1] + g[2]) / 3;
    final c0 = [g[0] - mean, g[1] - mean, g[2] - mean];
    final n = c0[0] * c0[0] + c0[1] * c0[1] + c0[2] * c0[2];
    final w = [c0[0] / n, c0[1] / n, c0[2] / n];
    final d = [t[0] - g[0], t[1] - g[1], t[2] - g[2]];
    final m = List<double>.filled(9, 0);
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        m[i * 3 + j] = tn[i] * ((i == j ? 1.0 : 0.0) + d[i] * w[j]);
      }
    }
    return m;
  }

  static List<double> mul3(List<double> a, List<double> b) {
    final r = List<double>.filled(9, 0);
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        var v = 0.0;
        for (var k = 0; k < 3; k++) {
          v += a[i * 3 + k] * b[k * 3 + j];
        }
        r[i * 3 + j] = v;
      }
    }
    return r;
  }

  static List<double> inv3(List<double> m) {
    final a = m[0], b = m[1], c = m[2];
    final d = m[3], e = m[4], f = m[5];
    final g = m[6], h = m[7], i = m[8];
    final det = a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g);
    if (det.abs() < 1e-9) return const [1, 0, 0, 0, 1, 0, 0, 0, 1];
    return <double>[
      (e * i - f * h) / det,
      (c * h - b * i) / det,
      (b * f - c * e) / det,
      (f * g - d * i) / det,
      (a * i - c * g) / det,
      (c * d - a * f) / det,
      (d * h - e * g) / det,
      (b * g - a * h) / det,
      (a * e - b * d) / det,
    ];
  }

  /// 5x4 matrix as needed by ColorFilter.matrix.
  static List<double> filterMatrix(List<double> m) => <double>[
        m[0], m[1], m[2], 0, 0,
        m[3], m[4], m[5], 0, 0,
        m[6], m[7], m[8], 0, 0,
        0, 0, 0, 1, 0,
      ];

  static Color applyTo(Color c, List<double> m) {
    final r = ((c.value >> 16) & 0xFF).toDouble();
    final g = ((c.value >> 8) & 0xFF).toDouble();
    final b = (c.value & 0xFF).toDouble();
    int ch(double v) => v.isNaN ? 0 : v.round().clamp(0, 255).toInt();
    return Color.fromARGB(
      255,
      ch(m[0] * r + m[1] * g + m[2] * b),
      ch(m[3] * r + m[4] * g + m[5] * b),
      ch(m[6] * r + m[7] * g + m[8] * b),
    );
  }

  /// The colour a theme shows for the main gold of the app.
  static Color swatch(AppThemeOption o) => o.color;
}

/// Remembers the chosen theme and tells the app when it changes.
class AppThemeStore extends ChangeNotifier {
  AppThemeStore._();
  static final AppThemeStore instance = AppThemeStore._();

  static const String _key = 'app_theme_id';

  AppThemeOption _current = AppThemes.all.first;
  late ColorFilter _filter = _build(_current, false);
  late ColorFilter _inverse = _build(_current, true);

  static final ColorFilter _identity = ColorFilter.matrix(
    AppThemes.filterMatrix(const [1, 0, 0, 0, 1, 0, 0, 0, 1]),
  );

  /// While true (the opening logo screen) the app is drawn in its original
  /// colours, so the logo never changes colour.
  bool _suspended = true;

  AppThemeOption get current => _current;
  ColorFilter get filter => _suspended ? _identity : _filter;
  ColorFilter get inverseFilter => _suspended ? _identity : _inverse;

  void setSuspended(bool v) {
    if (v == _suspended) return;
    _suspended = v;
    notifyListeners();
  }

  static ColorFilter _build(AppThemeOption o, bool inverse) {
    final m = AppThemes.matrix3(o);
    return ColorFilter.matrix(
      AppThemes.filterMatrix(inverse ? AppThemes.inv3(m) : m),
    );
  }

  void _set(AppThemeOption o) {
    _current = o;
    _filter = _build(o, false);
    _inverse = _build(o, true);
  }

  Future<void> load() async {
    try {
      final p = await SharedPreferences.getInstance();
      final o = AppThemes.byId(p.getString(_key));
      if (o.id != _current.id) {
        _set(o);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> select(AppThemeOption o) async {
    if (o.id == _current.id) return;
    _set(o);
    notifyListeners();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_key, o.id);
    } catch (_) {}
  }
}

/// Wraps the whole app: paints everything in the chosen theme.
class AppThemeLayer extends StatelessWidget {
  const AppThemeLayer({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppThemeStore.instance,
      child: child,
      builder: (context, c) => ColorFiltered(
        colorFilter: AppThemeStore.instance.filter,
        child: c,
      ),
    );
  }
}

/// Keeps the original colours of its child (logo, colour swatches).
class ThemeGuard extends StatelessWidget {
  const ThemeGuard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppThemeStore.instance,
      child: child,
      builder: (context, c) => ColorFiltered(
        colorFilter: AppThemeStore.instance.inverseFilter,
        child: c,
      ),
    );
  }
}
