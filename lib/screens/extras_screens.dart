import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

const Color _gold = Color(0xFFB8860B);
const Color _cream = Color(0xFFFAF5E8);

/// Returns the page for the extra home buttons (referral, pro).
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

  void _share() {
    final text = 'Ankdhara Numerology app try karo - apna ank-gyan jaano! '
        'Mera referral code: $code';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        title: const Text('Dost ko bulao'),
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
                  const Text(
                    'Apna referral code',
                    style: TextStyle(fontSize: 16),
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
                    onPressed: code == null ? null : _share,
                    icon: const Icon(Icons.share),
                    label: const Text('WhatsApp / share karo'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Dost ko app bhejo. Free report ka inaam tab milega jab '
                'online code-check shuru hoga. Tab tak apna code share '
                'kar sakte ho.',
                style: TextStyle(fontSize: 14),
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
                  const Text(
                    'Numerologists ke liye yearly Pro',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _row('Family profiles (5 tak)'),
                  _row('Roz ka lucky number aur colour'),
                  _row('Kuch reports plan ke andar shamil'),
                  _row('Sabhi normal features free hi rehte hain'),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: null,
                      child: Text('Jald aa raha hai'),
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
