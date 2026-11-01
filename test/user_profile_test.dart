import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cheiro_numerology/core/user_profile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('profile keeps house and vehicle number', () async {
    SharedPreferences.setMockInitialValues({
      'profile_house': 'B-204',
      'profile_vehicle': 'DL3CAB1234',
    });
    final p = UserProfile.instance;
    await p.ensureLoaded();
    expect(p.house, 'B-204');
    expect(p.vehicle, 'DL3CAB1234');
    expect(p.isEmpty, isFalse);

    // Saving without house/vehicle keeps the old ones.
    await p.save(name: 'Asha', dob: null, mobile: '9876543210');
    expect(p.house, 'B-204');
    expect(p.vehicle, 'DL3CAB1234');

    // Saving with new values replaces them.
    await p.save(
        name: 'Asha', dob: null, mobile: '9876543210', house: '12', vehicle: '');
    expect(p.house, '12');
    expect(p.vehicle, '');

    await p.clear();
    expect(p.house, '');
    expect(p.isEmpty, isTrue);
  });
}
