import 'package:flutter/material.dart';

import '../core/app_lock.dart';
import '../core/app_settings.dart';
import '../core/root_profiles.dart' show L;

/// Covers the whole app with a lock screen while the app lock is on and the
/// customer has not yet opened it. It locks again when the app has been in
/// the background for more than 30 seconds.
class LockGate extends StatefulWidget {
  final Widget? child;
  const LockGate({Key? key, this.child}) : super(key: key);

  @override
  State<LockGate> createState() => _LockGateState();
}

class _LockGateState extends State<LockGate> with WidgetsBindingObserver {
  DateTime? _leftAt;

  static const L _reason = L(
    'Open Ank Dhara',
    'अंक धारा खोलिए',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppLock.instance.addListener(_changed);
    WidgetsBinding.instance.addPostFrameCallback((_) => _ask());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppLock.instance.removeListener(_changed);
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  String get _text => AppSettings.instance.t(_reason);

  Future<void> _ask() async {
    final lock = AppLock.instance;
    if (lock.locked && !lock.busy) {
      await lock.unlock(_text);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lock = AppLock.instance;
    if (lock.busy) return; // the phone's own lock window is open
    if (state == AppLifecycleState.paused) {
      _leftAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      final t = _leftAt;
      _leftAt = null;
      if (t != null && DateTime.now().difference(t).inSeconds > 30) {
        lock.lock();
        _ask();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lock = AppLock.instance;
    final s = AppSettings.instance;
    return Stack(
      children: [
        Positioned.fill(child: widget.child ?? const SizedBox.shrink()),
        if (lock.enabled && lock.locked)
          Positioned.fill(
            child: Material(
              color: Colors.white,
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock_outline,
                            size: 56, color: Color(0xFFB8860B)),
                        const SizedBox(height: 16),
                        Text(
                          s.t(const L('Ank Dhara is locked', 'अंक धारा बंद है')),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.t(const L(
                            'Use your phone fingerprint, face or PIN to open.',
                            'खोलने के लिए फ़ोन का फ़िंगरप्रिंट, चेहरा या PIN इस्तेमाल कीजिए।',
                          )),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _ask,
                          icon: const Icon(Icons.lock_open),
                          label: Text(s.t(const L('Open', 'खोलिए'))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB8860B),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
