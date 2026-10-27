import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The one profile (name, date of birth, mobile) that every screen reuses.
/// It is saved only on this phone.
class UserProfile extends ChangeNotifier {
  UserProfile._();
  static final UserProfile instance = UserProfile._();

  static const String _kName = 'profile_name';
  static const String _kDob = 'profile_dob';
  static const String _kMobile = 'profile_mobile';

  String name = '';
  DateTime? dob;
  String mobile = '';

  bool _loaded = false;
  Future<void>? _loading;

  bool get loaded => _loaded;
  bool get isEmpty =>
      name.trim().isEmpty && dob == null && mobile.trim().isEmpty;

  /// Loads the saved profile once. Safe to call many times.
  Future<void> ensureLoaded() => _loading ??= _load();

  Future<void> _load() async {
    try {
      final p = await SharedPreferences.getInstance();
      name = p.getString(_kName) ?? '';
      mobile = p.getString(_kMobile) ?? '';
      final d = p.getString(_kDob);
      dob = d == null ? null : DateTime.tryParse(d);
    } catch (_) {
      // Nothing saved yet, or storage not available: start empty.
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> save({
    required String name,
    required DateTime? dob,
    required String mobile,
  }) async {
    this.name = name.trim();
    this.dob = dob;
    this.mobile = mobile.trim();
    _loaded = true;
    _loading ??= Future<void>.value();
    notifyListeners();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_kName, this.name);
      await p.setString(_kMobile, this.mobile);
      if (dob == null) {
        await p.remove(_kDob);
      } else {
        final m = dob.month.toString().padLeft(2, '0');
        final d = dob.day.toString().padLeft(2, '0');
        await p.setString(_kDob, '${dob.year}-$m-$d');
      }
    } catch (_) {
      // Saving is best effort.
    }
  }

  Future<void> clear() => save(name: '', dob: null, mobile: '');
}

/// A text box controller that starts with the saved name or mobile number.
/// It only fills the box if the box is still empty.
class ProfileController extends TextEditingController {
  ProfileController.name() : _mobile = false {
    _init();
  }

  ProfileController.mobile() : _mobile = true {
    _init();
  }

  final bool _mobile;
  bool _gone = false;

  void _init() {
    UserProfile.instance.ensureLoaded().then((_) {
      if (_gone || text.isNotEmpty) return;
      final p = UserProfile.instance;
      final v = _mobile ? p.mobile : p.name;
      if (v.isNotEmpty) text = v;
    });
  }

  @override
  void dispose() {
    _gone = true;
    super.dispose();
  }
}
