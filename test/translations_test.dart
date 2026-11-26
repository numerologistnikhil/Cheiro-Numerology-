import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/app_settings.dart';
import 'package:cheiro_numerology/core/translations.dart';

void main() {
  test('every translation row has one text per language', () {
    for (final e in Translations.table.entries) {
      expect(e.value.length, Translations.codes.length, reason: e.key);
      for (final t in e.value) {
        expect(t.trim().isNotEmpty, true, reason: e.key);
      }
    }
  });

  test('every listed language has a translation column or is en/hi', () {
    for (final l in AppLanguages.all) {
      if (l.code == 'en' || l.code == 'hi') continue;
      expect(Translations.codes.contains(l.code), true, reason: l.code);
    }
  });

  test('lookup falls back to null for unknown text', () {
    expect(Translations.lookup('es', 'Home'), 'Inicio');
    expect(Translations.lookup('es', 'No such text'), null);
    expect(Translations.lookup('xx', 'Home'), null);
  });
}
