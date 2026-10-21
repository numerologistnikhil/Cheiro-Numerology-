import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cheiro_numerology/core/entitlements.dart';
import 'package:cheiro_numerology/core/pricing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final afterFree =
      Pricing.billingConnected ? ReportAccess.needsPayment : ReportAccess.testing;

  test('first report is free, then payment rules apply', () async {
    SharedPreferences.setMockInitialValues({});
    expect(await Entitlements.check(), ReportAccess.freeFirst);
    await Entitlements.consume(ReportAccess.freeFirst);
    expect(await Entitlements.check(), afterFree);
  });

  test('paid credits are used one by one', () async {
    SharedPreferences.setMockInitialValues({
      'ent_free_report_used': true,
      'ent_report_credits': 2,
    });
    expect(await Entitlements.check(), ReportAccess.paidCredit);
    await Entitlements.consume(ReportAccess.paidCredit);
    expect(await Entitlements.credits(), 1);
    expect(await Entitlements.check(), ReportAccess.paidCredit);
    await Entitlements.consume(ReportAccess.paidCredit);
    expect(await Entitlements.credits(), 0);
    expect(await Entitlements.check(), afterFree);
  });

  test('addCredits adds and ignores zero or negative', () async {
    SharedPreferences.setMockInitialValues({'ent_free_report_used': true});
    await Entitlements.addCredits(3);
    await Entitlements.addCredits(0);
    await Entitlements.addCredits(-5);
    expect(await Entitlements.credits(), 3);
  });
}
