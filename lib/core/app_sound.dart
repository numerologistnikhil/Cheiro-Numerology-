import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_settings.dart';

/// Plays a soft tap sound when the customer taps anything in the app.
/// Uses the phone's own built-in click sound, so no extra files are needed.
/// It follows the Sound ON / OFF choice in Settings.
class AppSound {
  static void tap() {
    if (!AppSettings.instance.sound) return;
    SystemSound.play(SystemSoundType.click);
  }

  /// A slightly different feel for important actions (report ready, saved).
  static void success() {
    if (!AppSettings.instance.sound) return;
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.lightImpact();
  }
}

/// Wrap the whole app in this. A short touch (not a scroll) plays the sound.
class TapSound extends StatefulWidget {
  final Widget? child;
  const TapSound({Key? key, this.child}) : super(key: key);

  @override
  State<TapSound> createState() => _TapSoundState();
}

class _TapSoundState extends State<TapSound> {
  Offset? _down;
  int _downAt = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (e) {
        _down = e.position;
        _downAt = DateTime.now().millisecondsSinceEpoch;
      },
      onPointerUp: (e) {
        final d = _down;
        _down = null;
        if (d == null) return;
        final moved = (e.position - d).distance;
        final ms = DateTime.now().millisecondsSinceEpoch - _downAt;
        if (moved < 12 && ms < 400) AppSound.tap();
      },
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}
