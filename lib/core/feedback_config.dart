/// Where customer feedback is sent. It goes to a Google Form owned by the
/// app owner, so no personal email or phone number is shown in the app.
///
/// Fill these in after the Form is created (see docs/FEEDBACK_SETUP.md).
/// While [formResponseUrl] is empty the feedback screen shows a friendly
/// "not connected yet" message and nothing is sent.
class FeedbackConfig {
  /// Ends with /formResponse
  static const String formResponseUrl = '';

  static const String entryType = ''; // like entry.1111111111
  static const String entryMessage = '';
  static const String entryRating = '';
  static const String entryContact = '';
  static const String entryApp = '';

  static bool get connected =>
      formResponseUrl.isNotEmpty && entryMessage.isNotEmpty;
}
