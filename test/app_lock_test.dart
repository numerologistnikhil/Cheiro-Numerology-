import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/core/app_lock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('app lock is OFF by default', () async {
    SharedPreferences.setMockInitialValues({});
    AppLock.instance.resetForTest();
    await AppLock.instance.load();
    expect(AppLock.instance.enabled, false);
    expect(AppLock.instance.locked, false);
  });

  test('app lock saved as ON starts locked', () async {
    SharedPreferences.setMockInitialValues({'app_lock_enabled': true});
    AppLock.instance.resetForTest();
    await AppLock.instance.load();
    expect(AppLock.instance.enabled, true);
    expect(AppLock.instance.locked, true);
  });
}
