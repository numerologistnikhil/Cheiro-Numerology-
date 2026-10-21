/// One place for every price and pricing switch.
/// To change the report price later, only edit this file.
class Pricing {
  Pricing._();

  /// Price of one detailed PDF report, in rupees.
  static const int reportPriceRupees = 50;

  /// What the customer gets for that price (shown before any payment).
  static const String reportIncludes =
      'One detailed PDF report: download, print and WhatsApp/share of the '
      'same report. No extra charge for these options.';

  /// Keep this false until Google Play Billing is really connected.
  /// While false, the app does NOT block reports (test build), so that
  /// nobody is asked to pay through a payment system that does not exist.
  /// Set it to true only after the billing code and Play Console
  /// products are ready and tested.
  static const bool billingConnected = false;
}
