import 'package:flutter/material.dart';

import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

int _root9(int n) {
  var v = n;
  while (v > 9) {
    var s = 0;
    while (v > 0) {
      s += v % 10;
      v ~/= 10;
    }
    v = s;
  }
  return v;
}

int _digitSum(int n) {
  var s = 0;
  var v = n;
  while (v > 0) {
    s += v % 10;
    v ~/= 10;
  }
  return s;
}

/// One simple place to enter the customer's details. Every other screen and
/// the report builder start from these details.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  DateTime? _dob;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (!mounted) return;
      final p = UserProfile.instance;
      setState(() {
        _name.text = p.name;
        _mobile.text = p.mobile;
        _dob = p.dob;
        _ready = true;
      });
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    super.dispose();
  }

  Future<void> _save(bool hi) async {
    await UserProfile.instance.save(
      name: _name.text,
      dob: _dob,
      mobile: _mobile.text,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(hi
          ? 'जानकारी सेव हो गई। अब यह हर जगह अपने आप भर जाएगी।'
          : 'Details saved. They will now fill in everywhere automatically.'),
    ));
    Navigator.pop(context);
  }

  Future<void> _newPerson(bool hi) async {
    await UserProfile.instance.clear();
    if (!mounted) return;
    setState(() {
      _name.clear();
      _mobile.clear();
      _dob = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(hi
          ? 'पुरानी जानकारी हटा दी गई। नई जानकारी भरिए।'
          : 'Old details cleared. Enter the new details.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    final dob = _dob;
    return PageShell(
      title: hi ? 'प्रोफ़ाइल' : 'Profile',
      children: [
        Note(hi
            ? 'यहाँ जातक (जिसके अंक देखने हैं) की जानकारी एक ही बार भरिए। फिर हर सुविधा और रिपोर्ट में यही जानकारी अपने आप आ जाएगी। नए व्यक्ति के लिए "नया व्यक्ति" दबाइए।'
            : 'Enter the details of the person whose numbers you are reading just once here. Every feature and the report will then start with these details. For a new person, tap "New person".'),
        const SizedBox(height: 14),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          enabled: _ready,
          decoration: InputDecoration(
            labelText: hi ? 'पूरा नाम' : 'Full name',
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        DateField(
          label: hi ? 'जन्म तिथि' : 'Date of birth',
          value: dob,
          usesProfile: false,
          onChanged: (d) => setState(() => _dob = d),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _mobile,
          keyboardType: TextInputType.phone,
          enabled: _ready,
          decoration: InputDecoration(
            labelText: hi ? 'मोबाइल नंबर (ज़रूरी नहीं)' : 'Mobile number (optional)',
            prefixIcon: const Icon(Icons.phone_android),
          ),
        ),
        if (dob != null) ...[
          const SizedBox(height: 14),
          GoldCard(
            padding: const EdgeInsets.all(14),
            child: Text(
              hi
                  ? 'मूलांक: ${_root9(dob.day)}     भाग्यांक: ${_root9(_digitSum(dob.day) + _digitSum(dob.month) + _digitSum(dob.year))}'
                  : 'Mulank: ${_root9(dob.day)}     Bhagyank: ${_root9(_digitSum(dob.day) + _digitSum(dob.month) + _digitSum(dob.year))}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
        ],
        const SizedBox(height: 18),
        FilledButton(
          onPressed: _ready ? () => _save(hi) : null,
          child: Text(hi ? 'सेव कीजिए' : 'Save'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _ready ? () => _newPerson(hi) : null,
          child: Text(hi ? 'नया व्यक्ति (पुरानी जानकारी हटाइए)' : 'New person (clear old details)'),
        ),
      ],
    );
  }
}

/// Small card on the home screen: shows who is selected, opens the profile.
class ProfileStrip extends StatefulWidget {
  const ProfileStrip({super.key});

  @override
  State<ProfileStrip> createState() => _ProfileStripState();
}

class _ProfileStripState extends State<ProfileStrip> {
  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded();
  }

  String _dobText(DateTime d) => '${d.day}/${d.month}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    return AnimatedBuilder(
      animation: UserProfile.instance,
      builder: (context, _) {
        final p = UserProfile.instance;
        final empty = p.isEmpty;
        final title = empty
            ? (hi ? 'अपनी जानकारी एक बार भरिए' : 'Add your details once')
            : (p.name.isEmpty ? (hi ? 'प्रोफ़ाइल' : 'Profile') : p.name);
        final parts = <String>[
          if (p.dob != null) _dobText(p.dob!),
          if (p.mobile.isNotEmpty) p.mobile,
        ];
        final sub = empty
            ? (hi
                ? 'नाम, जन्म तिथि, मोबाइल: हर जगह अपने आप भर जाएँगे'
                : 'Name, date of birth, mobile: filled in everywhere automatically')
            : parts.join('   ');
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AnkdharaColors.goldLine),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_circle_outlined,
                      color: AnkdharaColors.gold, size: 30),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        if (sub.isNotEmpty)
                          Text(
                            sub,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF6F6650)),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    empty ? (hi ? 'भरिए' : 'Add') : (hi ? 'बदलिए' : 'Edit'),
                    style: const TextStyle(
                        color: AnkdharaColors.gold, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
