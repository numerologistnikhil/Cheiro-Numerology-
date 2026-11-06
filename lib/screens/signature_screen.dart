import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

import '../core/app_settings.dart';
import '../core/numerology_engine.dart';
import '../core/root_profiles.dart' show L;
import '../core/signature_analysis.dart';
import '../core/signature_image.dart';
import '../core/signature_reading.dart';
import '../core/story_report.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final _name = ProfileController.name();
  Uint8List? _photo;
  PreparedSignature? _prepared;
  SizeVsHand _size = SizeVsHand.same;
  Legibility _leg = Legibility.clear;
  SignatureReading? _reading;
  String? _error;
  bool _busy = false;
  bool _reportBusy = false;
  bool _include = SignatureStore.include;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pick(AppSettings s) async {
    try {
      final x = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1600);
      if (x == null) return;
      final bytes = await x.readAsBytes();
      final prep = SignatureImage.prepare(bytes);
      setState(() {
        _photo = bytes;
        _prepared = prep;
        _reading = null;
        _error = prep == null ? s.t(SignatureReading.bad) : null;
      });
    } catch (_) {
      if (mounted) setState(() => _error = s.t(SignatureReading.bad));
    }
  }

  Future<void> _analyse(AppSettings s) async {
    final p = _prepared;
    if (p == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final m = SignatureAnalyzer.analyze(p.ink, p.width, p.height);
    if (m == null) {
      setState(() {
        _busy = false;
        _reading = null;
        _error = s.t(SignatureReading.noInk);
      });
      return;
    }
    int? mu, bh;
    final dob = UserProfile.instance.dob;
    if (dob != null) {
      final b = NumerologyEngine.birth(dob);
      mu = b.psychic.root;
      bh = b.destiny.root;
    }
    final r = SignatureReading.build(
      m: m,
      size: _size,
      legibility: _leg,
      name: _name.text,
      mulank: mu,
      bhagyank: bh,
    );
    SignatureStore.photo = p.jpeg;
    SignatureStore.reading = r;
    SignatureStore.name = _name.text.trim();
    SignatureStore.include = _include;
    setState(() {
      _busy = false;
      _reading = r;
    });
  }

  Future<void> _report(AppSettings s) async {
    final dob = UserProfile.instance.dob;
    final nm = UserProfile.instance.name.trim().isEmpty ? _name.text.trim() : UserProfile.instance.name.trim();
    if (dob == null || nm.isEmpty) {
      setState(() => _error = s.hindi
          ? 'रिपोर्ट के लिए प्रोफ़ाइल में नाम और जन्म तिथि भरें।'
          : 'Please fill your name and date of birth in the Profile first.');
      return;
    }
    SignatureStore.include = true;
    setState(() {
      _reportBusy = true;
      _error = null;
      _include = true;
    });
    try {
      Uint8List? logo;
      try {
        final data = await rootBundle.load('assets/images/ankdhara_logo.png');
        logo = data.buffer.asUint8List();
      } catch (_) {}
      await StoryReport.preview(name: nm, dob: dob, logo: logo, hindi: s.hindi, sample: true);
    } catch (_) {
      if (mounted) setState(() => _error = s.hindi ? 'रिपोर्ट नहीं बन सकी।' : 'Could not make the report.');
    }
    if (mounted) setState(() => _reportBusy = false);
  }

  Widget _options<T>(AppSettings s, Map<T, L> opts, T value, void Function(T) on) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final e in opts.entries)
          ChoiceChip(
            label: Text(s.t(e.value)),
            selected: value == e.key,
            onSelected: (_) => setState(() {
              on(e.key);
              _reading = null;
            }),
          ),
      ],
    );
  }

  Widget _finding(AppSettings s, SigFinding f) {
    final c = f.tone > 0
        ? const Color(0xFF2E7D32)
        : (f.tone < 0 ? const Color(0xFFC0392B) : const Color(0xFFB8860B));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.draw_outlined, color: c, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(s.t(f.title),
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
              ),
            ]),
            const SizedBox(height: 6),
            Text('${s.t(SignatureReading.measuredLabel)}: ${f.measured}',
                style: TextStyle(fontSize: 12.5, color: c, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(s.t(f.reading), style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 6),
            Text('${s.t(SignatureReading.tipLabel)}: ${s.t(f.tip)}',
                style: const TextStyle(fontSize: 13.5, height: 1.45, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final r = _reading;
    final kids = <Widget>[
      Note(s.t(SignatureReading.intro)),
      InfoRow(Icons.info_outline, s.hindi ? 'ज़रूरी' : 'Please read', s.t(SignatureReading.honest)),
      InfoRow(Icons.photo_camera_outlined, s.hindi ? 'फोटो कैसे लें' : 'Photo tips', s.t(SignatureReading.photoTips)),
      const SizedBox(height: 12),
      TextField(
        controller: _name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: s.t(SignatureReading.nameLabel),
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
      ),
      const SizedBox(height: 12),
      Text(s.t(SignatureReading.sizeQ), style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      _options<SizeVsHand>(s, SignatureReading.sizeOpt, _size, (v) => _size = v),
      const SizedBox(height: 12),
      Text(s.t(SignatureReading.legQ), style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      _options<Legibility>(s, SignatureReading.legOpt, _leg, (v) => _leg = v),
      const SizedBox(height: 14),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _pick(s),
          icon: const Icon(Icons.image_outlined),
          label: Text(s.t(_photo == null ? SignatureReading.pick : SignatureReading.change)),
        ),
      ),
    ];
    if (_photo != null) {
      kids.add(const SizedBox(height: 10));
      kids.add(Container(
        constraints: const BoxConstraints(maxHeight: 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x55B8860B)),
        ),
        padding: const EdgeInsets.all(6),
        child: Image.memory(_photo!, fit: BoxFit.contain),
      ));
      kids.add(const SizedBox(height: 10));
      kids.add(SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: (_busy || _prepared == null) ? null : () => _analyse(s),
          icon: const Icon(Icons.auto_graph),
          label: Text(s.t(_busy ? SignatureReading.working : SignatureReading.analyse)),
        ),
      ));
    }
    if (_error != null) {
      kids.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(_error!, style: const TextStyle(color: Color(0xFFC0392B))),
      ));
    }
    if (r != null) {
      kids.add(SectionLabel(s.t(SignatureReading.resultHead)));
      for (final f in r.findings) {
        kids.add(_finding(s, f));
      }
      final n = r.number;
      if (n != null) {
        kids.add(InfoRow(
          Icons.pin_outlined,
          '${s.t(SignatureReading.numberHead)}: ${n.total}/${n.root}',
          s.t(SignatureReading.relationLine(n)),
        ));
      }
      final good = r.findings.where((f) => f.tone > 0).length;
      final care = r.findings.where((f) => f.tone < 0).length;
      kids.add(SectionLabel(s.t(SignatureReading.summaryHead)));
      kids.add(Text(
        s.hindi
            ? '$good मज़बूत बातें और $care ध्यान देने की बातें मिलीं। बाकी तटस्थ हैं। याद रखें, यह परंपरा पर आधारित आईना है, फ़ैसला नहीं।'
            : '$good strong points and $care points to watch were found. The rest are neutral. Remember, this is a traditional mirror, not a verdict.',
        style: const TextStyle(fontSize: 14, height: 1.5),
      ));
      kids.add(SectionLabel(s.t(SignatureReading.improveHead)));
      for (final t in SignatureReading.improve) {
        kids.add(Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('•  ${s.t(t)}', style: const TextStyle(fontSize: 14, height: 1.45)),
        ));
      }
      kids.add(const SizedBox(height: 12));
      kids.add(SwitchListTile(
        contentPadding: EdgeInsets.zero,
        value: _include,
        title: Text(s.t(SignatureReading.addToPdf)),
        subtitle: _include ? Text(s.t(SignatureReading.added)) : null,
        onChanged: (v) => setState(() {
          _include = v;
          SignatureStore.include = v;
        }),
      ));
      kids.add(SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _reportBusy ? null : () => _report(s),
          icon: const Icon(Icons.picture_as_pdf_outlined),
          label: Text(s.t(SignatureReading.openPdf)),
        ),
      ));
    }
    kids.add(const SizedBox(height: 14));
    return PageShell(title: s.t(SignatureReading.title), children: kids);
  }
}
