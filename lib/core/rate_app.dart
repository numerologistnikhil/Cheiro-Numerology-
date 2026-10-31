import 'package:in_app_review/in_app_review.dart';
import 'root_profiles.dart' show L;

/// "Rate us on the Play Store" for every app. The Google review box opens
/// only for an app installed from the Play Store, so in a test APK nothing
/// may appear. Never offer anything in return for a rating (Play policy).
class RateApp {
  static const L button = L('Rate us on Play Store', 'प्ले स्टोर पर रेटिंग दीजिए');
  static const L sub = L('Liked the app or your report? A rating helps a lot.',
      'ऐप या रिपोर्ट पसंद आई? आपकी रेटिंग से बहुत मदद मिलती है।');

  static Future<void> open() async {
    try {
      final r = InAppReview.instance;
      if (await r.isAvailable()) {
        await r.requestReview();
      } else {
        await r.openStoreListing();
      }
    } catch (_) {
      // Rating is optional; never block the app.
    }
  }
}
