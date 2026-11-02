import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/app_theme.dart';

int _ch(Color c, int shift) => (c.value >> shift) & 0xFF;

void _near(Color a, Color b, String why) {
  for (final sh in [16, 8, 0]) {
    expect((_ch(a, sh) - _ch(b, sh)).abs() <= 2, isTrue,
        reason: '$why (${a.value.toRadixString(16)} vs ${b.value.toRadixString(16)})');
  }
}

void main() {
  test('there are ten themes with unique ids and none is paid yet', () {
    expect(AppThemes.all.length, 10);
    expect(AppThemes.all.map((e) => e.id).toSet().length, 10);
    expect(AppThemes.all.any((e) => e.premiumOnly), isFalse);
    expect(AppThemes.all.map((e) => e.color.value).toSet().length, 10);
  });

  test('default theme keeps gold and white', () {
    final m = AppThemes.matrix3(AppThemes.all.first);
    _near(AppThemes.applyTo(AppThemes.baseGold, m), AppThemes.baseGold, 'gold');
    expect(AppThemes.applyTo(const Color(0xFFFFFFFF), m).value, 0xFFFFFFFF);
  });

  test('gold becomes the theme colour, white the tint, black stays', () {
    for (final o in AppThemes.all) {
      final m = AppThemes.matrix3(o);
      _near(AppThemes.applyTo(AppThemes.baseGold, m), o.color, '${o.id} gold');
      _near(AppThemes.applyTo(const Color(0xFFFFFFFF), m), o.tint, '${o.id} white');
      expect(AppThemes.applyTo(const Color(0xFF000000), m).value, 0xFF000000, reason: o.id);
    }
  });

  test('inverse undoes the theme', () {
    for (final o in AppThemes.all) {
      final m = AppThemes.matrix3(o);
      final back = AppThemes.mul3(AppThemes.inv3(m), m);
      for (var i = 0; i < 9; i++) {
        expect(back[i], closeTo(i % 4 == 0 ? 1 : 0, 1e-6), reason: o.id);
      }
    }
  });
}
