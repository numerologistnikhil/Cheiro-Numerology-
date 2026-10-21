import 'package:shared_preferences/shared_preferences.dart';
import 'pricing.dart';

/// What the customer may do right now when they ask for a report.
enum ReportAccess {
  /// The very first detailed report is free.
  freeFirst,

  /// The customer has a paid (or coupon) report credit.
  paidCredit,

  /// No free report and no credit left: payment is required.
  needsPayment,

  /// Test build: payment is not connected yet, so reports stay free.
  testing,
}

/// Keeps track of free and paid reports on this phone.
/// All normal app features stay free; only the detailed PDF report is
/// gated here.
class Entitlements {
  Entitlements._();

  static const _kFreeUsed = 'ent_free_report_used';
  static const _kCredits = 'ent_report_credits';

  static Future<ReportAccess> check() async {
    final p = await SharedPreferences.getInstance();
    if (!(p.getBool(_kFreeUsed) ?? false)) return ReportAccess.freeFirst;
    if ((p.getInt(_kCredits) ?? 0) > 0) return ReportAccess.paidCredit;
    return Pricing.billingConnected
        ? ReportAccess.needsPayment
        : ReportAccess.testing;
  }

  /// Call only after the report has really been created.
  static Future<void> consume(ReportAccess access) async {
    final p = await SharedPreferences.getInstance();
    if (access == ReportAccess.freeFirst) {
      await p.setBool(_kFreeUsed, true);
    } else if (access == ReportAccess.paidCredit) {
      final left = (p.getInt(_kCredits) ?? 0) - 1;
      await p.setInt(_kCredits, left < 0 ? 0 : left);
    }
  }

  /// Adds report credits. This must be called ONLY by verified payment
  /// code or a valid coupon, never from a normal button.
  static Future<void> addCredits(int count) async {
    if (count <= 0) return;
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kCredits, (p.getInt(_kCredits) ?? 0) + count);
  }

  static Future<int> credits() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kCredits) ?? 0;
  }
}
