import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/root_profiles.dart' show L;

/// The "Colour theme" box in Settings: ten colour combinations.
class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final store = AppThemeStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x55B8860B)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.t(const L(
                  'Choose the colour you like. The app changes at once and remembers your choice.',
                  'अपना पसंदीदा रंग चुनिए। ऐप तुरंत बदल जाता है और आपकी पसंद याद रखता है।',
                )),
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 14),
              ThemeGuard(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 14,
                  children: [
                    for (final o in AppThemes.all) _swatch(s, store, o),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                s.t(const L(
                  'Your PDF reports keep their own white and gold design.',
                  'आपकी PDF रिपोर्ट अपने सफ़ेद और सुनहरे डिज़ाइन में ही रहती है।',
                )),
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _swatch(AppSettings s, AppThemeStore store, AppThemeOption o) {
    final selected = store.current.id == o.id;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => store.select(o),
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [o.color, o.color, o.tint, o.tint],
                  stops: const [0, 0.5, 0.5, 1],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? const Color(0xFF2B2418) : Colors.black26,
                  width: selected ? 3 : 1,
                ),
              ),
              child: selected
                  ? Icon(Icons.check,
                      color: o.id == 'pearl_gold' ? o.color : Colors.white,
                      size: 24)
                  : null,
            ),
            const SizedBox(height: 5),
            Text(
              s.t(o.name),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                color: const Color(0xFF2B2418),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
