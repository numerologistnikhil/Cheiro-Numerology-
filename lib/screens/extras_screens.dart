import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_settings.dart';
import '../core/root_profiles.dart' show L;

const Color _gold = Color(0xFFB8860B);
const Color _cream = Color(0xFFFAF5E8);

/// Returns the page for the extra buttons (referral, pro).
Widget extraPage(String key) {
  if (key == 'pro') return const ProPlanScreen();
  return const ReferralScreen();
}

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  String? code;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    var c = p.getString('ref_my_code');
    if (c == null) {
      const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
      final r = Random.secure();
      c = 'ANK${List.generate(5, (_) => chars[r.nextInt(chars.length)]).join()}';
      await p.setString('ref_my_code', c);
    }
    if (mounted) setState(() => code = c);
  }

  void _share(AppSettings s) {
    final text = s.hindi
        ? 'अंकधारा अंक-ज्योतिष ऐप आज़माइए! मेरा रेफ़रल कोड: $code'
        : 'Try the Ankdhara numerology app! My referral code: $code';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        title: Text(s.t(const L('Invite a friend', 'दोस्त को बुलाइए'))),
        backgroundColor: _cream,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.card_giftcard, size: 48, color: _gold),
                  const SizedBox(height: 12),
                  Text(
                    s.t(const L('Your referral code', 'आपका रेफ़रल कोड')),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    code ?? '...',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: _gold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: _gold),
                    onPressed: code == null ? null : () => _share(s),
                    icon: const Icon(Icons.share),
                    label: Text(s.t(const L('Share on WhatsApp or other apps',
                        'WhatsApp या दूसरे ऐप पर भेजें'))),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                s.t(const L(
                  'Send the app to your friends with your code. The free '
                      'report reward will start when online code checking '
                      'is added. Until then you can share your code.',
                  'अपने कोड के साथ ऐप दोस्तों को भेजिए। मुफ़्त रिपोर्ट का '
                      'इनाम तब शुरू होगा जब ऑनलाइन कोड जाँच जुड़ जाएगी। तब '
                      'तक आप अपना कोड बाँट सकते हैं।',
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

class ProPlanScreen extends StatelessWidget {
  const ProPlanScreen({super.key});

  Widget _row(String t) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: _gold, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(t, style: const TextStyle(fontSize: 15))),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        title: const Text('Ankdhara Pro'),
        backgroundColor: _cream,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.t(const L('Yearly plan for numerologists',
                        'अंक-ज्योतिषियों के लिए सालाना प्लान')),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _row(s.t(const L('Family profiles (up to 5)',
                      'परिवार की प्रोफ़ाइल (5 तक)'))),
                  _row(s.t(const L('Daily lucky number and colour',
                      'रोज़ का शुभ अंक और रंग'))),
                  _row(s.t(const L('Some reports included in the plan',
                      'कुछ रिपोर्ट प्लान में शामिल'))),
                  _row(s.t(const L('All normal features stay free',
                      'सभी सामान्य सुविधाएँ मुफ़्त रहती हैं'))),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: null,
                      child: Text(s.t(const L('Coming soon', 'जल्द आ रहा है'))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
