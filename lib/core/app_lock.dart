import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App lock: the customer opens the app with the phone's own fingerprint,
/// face, PIN or pattern. Ank Dhara never sees or stores the PIN.
class AppLock extends ChangeNotifier {
  AppLock._();
  static final AppLock instance = AppLock._();

  static const String _kEnabled = 'app_lock_enabled';

  final LocalAuthentication _auth = LocalAuthentication();

  bool _enabled = false;
  bool _locked = false;
  bool busy = false; // true while the phone's own lock window is open

  bool get enabled => _enabled;
  bool get locked => _locked;

  Future<void> load() async {
    try {
      final p = await SharedPreferences.getInstance();
      _enabled = p.getBool(_kEnabled) ?? false;
    } catch (_) {
      _enabled = false;
    }
    _locked = _enabled; // a locked app starts locked
    notifyListeners();
  }

  /// Does this phone have a screen lock (PIN, pattern, fingerprint, face)?
  Future<bool> supported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Opens the phone's lock window. Returns true when the customer passes.
  Future<bool> authenticate(String reason) async {
    if (busy) return false;
    busy = true;
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    } finally {
      busy = false;
    }
  }

  /// Turns the lock on or off. Returns false if it could not be changed
  /// (no screen lock on the phone, or the customer did not pass the check).
  Future<bool> setEnabled(bool v, String reason) async {
    if (v == _enabled) return true;
    if (!await supported()) return false;
    if (!await authenticate(reason)) return false;
    _enabled = v;
    _locked = false;
    notifyListeners();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setBool(_kEnabled, v);
    } catch (_) {
      // Saving is best effort.
    }
    return true;
  }

  void lock() {
    if (_enabled && !_locked) {
      _locked = true;
      notifyListeners();
    }
  }

  Future<void> unlock(String reason) async {
    if (!_locked) return;
    if (await authenticate(reason)) {
      _locked = false;
      notifyListeners();
    }
  }

  /// For tests only.
  @visibleForTesting
  void resetForTest() {
    _enabled = false;
    _locked = false;
    busy = false;
  }
}
