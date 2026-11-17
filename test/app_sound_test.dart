import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/core/app_settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('sound is ON by default and the choice is saved', () async {
    SharedPreferences.setMockInitialValues({});
    final s = AppSettings.instance;
    await s.load();
    expect(s.sound, true);
    await s.setSound(false);
    expect(s.sound, false);
    final p = await SharedPreferences.getInstance();
    expect(p.getBool('app_sound'), false);
    await s.setSound(true);
    expect(s.sound, true);
  });
}
