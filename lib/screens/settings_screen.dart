import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/app_settings.dart';
import '../core/pricing.dart';
import '../core/rate_app.dart';
import '../core/root_profiles.dart' show L;
import 'extras_screens.dart';

const Color _gold = Color(0xFFB8860B);
const Color _cream = Color(0xFFFFFFFF);
const Color _line = Color(0x55B8860B);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            color: _gold,
          ),
        ),
      );

  Widget _box(Widget child) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _line),
        ),
        child: child,
      );

  Widget _tile(IconData icon, String title, String sub, VoidCallback onTap) {
    return _box(
      ListTile(
        leading: Icon(icon, color: _gold),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final price = s.hindi
        ? '₹${Pricing.reportPriceRupees}'
        : 'Rs ${Pricing.reportPriceRupees}';

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        title: Text(s.t(const L('Settings', 'सेटिंग्स'))),
        backgroundColor: _cream,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
        children: [
          _title(s.t(const L('LANGUAGE', 'भाषा'))),
          _box(
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment<bool>(value: false, label: Text('English')),
                        ButtonSegment<bool>(value: true, label: Text('हिन्दी')),
                      ],
                      selected: {s.hindi},
                      onSelectionChanged: (v) => s.setHindi(v.first),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.t(const L(
                      'This sets the language of the app and the default '
                          'language of your reports.',
                      'यह ऐप की भाषा और आपकी रिपोर्ट की शुरुआती भाषा तय '
                          'करता है।',
                    )),
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          _title(s.t(const L('YOUR PLAN', 'आपका प्लान'))),
          _box(
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                s.hindi
                    ? 'ऐप की सभी सुविधाएँ मुफ़्त हैं। पहली विस्तृत रिपोर्ट मुफ़्त '
                        'है। उसके बाद हर रिपोर्ट $price की है, जिसमें डाउनलोड, '
                        'प्रिंट और शेयर शामिल हैं। भुगतान अभी इस टेस्ट वर्ज़न में '
                        'जुड़ा नहीं है।'
                    : 'All app features are free. Your first detailed report is '
                        'free. After that each report is $price, with download, '
                        'print and share included. Payment is not connected in '
                        'this test version yet.',
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ),
          _title(s.t(const L('MORE', 'और'))),
          _tile(Icons.star_outline, s.t(RateApp.button), s.t(RateApp.sub),
              RateApp.open),
          const SizedBox(height: 10),
          _tile(
            Icons.card_giftcard,
            s.t(const L('Invite a friend', 'दोस्त को बुलाइए')),
            s.t(const L('Share your referral code', 'अपना रेफ़रल कोड भेजिए')),
            () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ReferralScreen()),
            ),
          ),
          const SizedBox(height: 10),
          _tile(
            Icons.workspace_premium_outlined,
            'Ank Dhara Pro',
            s.t(const L('Yearly plan for numerologists',
                'अंक-ज्योतिषियों के लिए सालाना प्लान')),
            () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ProPlanScreen()),
            ),
          ),
          const SizedBox(height: 10),
          _tile(
            Icons.share_outlined,
            s.t(const L('Share this app', 'यह ऐप शेयर करें')),
            s.t(const L('Send it to family and friends',
                'परिवार और दोस्तों को भेजिए')),
            () => Share.share(s.t(const L(
              'Try Ank Dhara, a simple numerology app in English and Hindi.',
              'अंक धारा आज़माइए, हिन्दी और अंग्रेज़ी में एक आसान अंक-ज्योतिष ऐप।',
            ))),
          ),
          _title(s.t(const L('ABOUT', 'जानकारी'))),
          _box(
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                s.t(const L(
                  'Ank Dhara 1.0.0\n\n'
                      'Your profiles, reports and vault stay on this phone.\n\n'
                      'Numerology is a traditional system for reflection. It '
                      'does not guarantee results and is not medical, legal '
                      'or financial advice.',
                  'अंक धारा 1.0.0\n\n'
                      'आपकी प्रोफ़ाइल, रिपोर्ट और वॉल्ट इसी फ़ोन में रहते हैं।\n\n'
                      'अंक-ज्योतिष सोच-विचार के लिए एक पारंपरिक पद्धति है। यह '
                      'नतीजों की गारंटी नहीं देता और चिकित्सा, कानूनी या वित्तीय '
                      'सलाह नहीं है।',
                )),
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
