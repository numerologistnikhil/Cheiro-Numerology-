import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_style.dart';
import '../core/root_profiles.dart' show L;
import 'premium_home.dart';
import 'theme_picker.dart';

const Color _gold = Color(0xFFB8860B);

/// Shown once, after the opening logo: language, numerology style, colour.
class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  Widget _head(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 22, 4, 8),
        child: Text(t,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1, color: _gold)),
      );

  Future<void> _done(BuildContext context) async {
    await AppStyle.instance.finishSetup();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PremiumHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: AppStyle.instance,
          builder: (context, _) {
            final cur = AppStyle.instance.style;
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
              children: [
                Text(
                  s.t(const L('Set up your app', 'अपना ऐप सेट करें')),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  s.t(const L(
                    'Choose once, so the app starts the way you like. Everything can be changed later in Settings.',
                    'एक बार चुनिए, ताकि ऐप आपकी पसंद से शुरू हो। सब कुछ बाद में सेटिंग्स में बदला जा सकता है।')),
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
                _head(s.t(const L('1. LANGUAGE', '1. भाषा'))),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final lang in AppLanguages.all)
                      ChoiceChip(
                        label: Text(lang.native),
                        selected: lang.hindi == s.hindi,
                        selectedColor: const Color(0xFFF3DFA2),
                        onSelected: (_) => s.setHindi(lang.hindi),
                      ),
                  ],
                ),
                _head(s.t(const L('2. NUMEROLOGY STYLE', '2. अंकशास्त्र की पद्धति'))),
                for (final v in NumerologyStyle.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => AppStyle.instance.setStyle(v),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: v == cur ? _gold : const Color(0x55B8860B),
                              width: v == cur ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Icon(v == cur ? Icons.radio_button_checked : Icons.radio_button_off,
                                color: _gold),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.t(StyleTexts.names[v]!),
                                      style: const TextStyle(fontWeight: FontWeight.w800)),
                                  Text(s.t(StyleTexts.notes[v]!),
                                      style: const TextStyle(fontSize: 12.5, height: 1.35)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                _head(s.t(const L('3. COLOUR THEME', '3. ऐप का रंग'))),
                const ThemePicker(),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _done(context),
                    child: Text(s.t(const L('Start', 'शुरू करें'))),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
