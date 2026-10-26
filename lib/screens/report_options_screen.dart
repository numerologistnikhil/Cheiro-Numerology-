import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';

import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/report_options.dart';
import 'ui_kit.dart';

/// Separate "PDF options" page: language, years, print colour, colour
/// combination, border style, footer lines. Returns the chosen
/// [ReportOptions] when the customer taps "Save options".
class ReportOptionsScreen extends StatefulWidget {
  const ReportOptionsScreen({super.key, required this.initial});

  final ReportOptions initial;

  @override
  State<ReportOptionsScreen> createState() => _ReportOptionsScreenState();
}

class _ReportOptionsScreenState extends State<ReportOptionsScreen> {
  late ReportOptions _o;
  final TextEditingController _f1 = TextEditingController();
  final TextEditingController _f2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _o = widget.initial;
    _f1.text = _o.footerLine1;
    _f2.text = _o.footerLine2;
  }

  @override
  void dispose() {
    _f1.dispose();
    _f2.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(
      context,
      _o.copyWith(
        footerLine1: ReportOptions.cleanFooter(_f1.text),
        footerLine2: ReportOptions.cleanFooter(_f2.text),
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26, width: 0.8),
        ),
      );

  Widget _swatch(PaletteOption p, bool hi) {
    final sel = !_o.blackWhite && _o.paletteId == p.id;
    return Opacity(
      opacity: _o.blackWhite ? 0.35 : 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _o.blackWhite
            ? null
            : () => setState(() => _o = _o.copyWith(paletteId: p.id)),
        child: Container(
          width: 98,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: sel ? AnkdharaColors.gold : AnkdharaColors.goldLine,
              width: sel ? 2.4 : 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(Color(p.primary)),
                  const SizedBox(width: 4),
                  _dot(Color(p.accent)),
                  const SizedBox(width: 4),
                  _dot(Color(p.tint)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                p.name(hi),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _borderTile(BorderStyleOption b, bool hi) {
    final sel = _o.borderId == b.id;
    final col = _o.blackWhite ? Colors.black : Color(_o.palette.primary);
    final soft = _o.blackWhite ? Colors.black54 : Color(_o.palette.accent);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _o = _o.copyWith(borderId: b.id)),
      child: Container(
        width: 98,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: sel ? AnkdharaColors.gold : AnkdharaColors.goldLine,
            width: sel ? 2.4 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 68,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12, width: 0.8),
              ),
              child: CustomPaint(painter: _BorderPreview(b, col, soft)),
            ),
            const SizedBox(height: 6),
            Text(
              b.name(hi),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    String s(String en, String hin) => hi ? hin : en;

    return PageShell(
      title: s('PDF options', 'PDF विकल्प'),
      children: [
        Note(s(
          'Choose how your printed report should look. These choices are saved on this phone and used for every report until you change them.',
          'चुनिए कि आपकी छपी हुई रिपोर्ट कैसी दिखे। ये चुनाव इस फ़ोन में सेव रहते हैं और बदलने तक हर रिपोर्ट में लगते हैं।',
        )),
        SectionLabel(s('Report language', 'रिपोर्ट की भाषा')),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(value: false, label: Text('English')),
              ButtonSegment<bool>(value: true, label: Text('हिन्दी')),
            ],
            selected: {_o.hindi},
            onSelectionChanged: (v) => setState(() => _o = _o.copyWith(hindi: v.first)),
          ),
        ),
        SectionLabel(s('Future years in the report', 'रिपोर्ट में आगे के साल')),
        Row(
          children: [
            IconButton(
              onPressed: _o.years > 1
                  ? () => setState(() => _o = _o.copyWith(years: _o.years - 1))
                  : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Expanded(
              child: Center(
                child: Text(
                  s('${_o.years} years of predictions', '${_o.years} साल की भविष्यवाणी'),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            IconButton(
              onPressed: _o.years < 50
                  ? () => setState(() => _o = _o.copyWith(years: _o.years + 1))
                  : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final n in [5, 10, 15, 20, 30])
              ChoiceChip(
                label: Text('$n'),
                selected: _o.years == n,
                onSelected: (_) => setState(() => _o = _o.copyWith(years: n)),
              ),
          ],
        ),
        SectionLabel(s('Printout type', 'प्रिंटआउट का प्रकार')),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment<bool>(
                value: false,
                icon: const Icon(Icons.palette_outlined),
                label: Text(s('Colourful', 'रंगीन')),
              ),
              ButtonSegment<bool>(
                value: true,
                icon: const Icon(Icons.contrast),
                label: Text(s('Black & white', 'ब्लैक एंड व्हाइट')),
              ),
            ],
            selected: {_o.blackWhite},
            onSelectionChanged: (v) => setState(() => _o = _o.copyWith(blackWhite: v.first)),
          ),
        ),
        SectionLabel(s('Colour combination', 'रंगों का मेल')),
        if (_o.blackWhite)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              s('Colours are not used in a black and white printout.',
                  'ब्लैक एंड व्हाइट प्रिंटआउट में रंग इस्तेमाल नहीं होते।'),
              style: const TextStyle(fontSize: 12.5),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final p in ReportOptions.palettes) _swatch(p, hi)],
        ),
        SectionLabel(s('Page border', 'पन्ने का बॉर्डर')),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final b in ReportOptions.borders) _borderTile(b, hi)],
        ),
        SectionLabel(s('Line at the bottom of every page', 'हर पन्ने के नीचे की लाइन')),
        TextField(
          controller: _f1,
          maxLength: ReportOptions.maxFooterChars,
          decoration: InputDecoration(
            labelText: s('Footer line 1', 'नीचे की लाइन 1'),
            counterText: '',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _f2,
          maxLength: ReportOptions.maxFooterChars,
          decoration: InputDecoration(
            labelText: s('Footer line 2 (optional)', 'नीचे की लाइन 2 (ज़रूरी नहीं)'),
            counterText: '',
          ),
        ),
        Note(s(
          'Write your name, shop, phone number or a short message. It is printed at the bottom of every page. Leave both lines empty to show only "Ank Dhara".',
          'अपना नाम, दुकान, फ़ोन नंबर या कोई छोटा संदेश लिखिए। यह हर पन्ने के नीचे छपेगा। दोनों लाइन खाली छोड़ें तो सिर्फ़ "Ank Dhara" दिखेगा।',
        )),
        SectionLabel(s('Extra sections', 'अतिरिक्त हिस्से')),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s('Angel numbers section', 'एंजल नंबर वाला हिस्सा')),
          subtitle: Text(s('Meanings and the link with the date of birth',
              'मतलब और जन्मतिथि से संबंध')),
          value: _o.includeAngelNumbers,
          onChanged: (v) => setState(() => _o = _o.copyWith(includeAngelNumbers: v)),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: Text(s('Save options', 'विकल्प सेव करें')),
          ),
        ),
      ],
    );
  }
}

/// Tiny drawing of a page border, used on the border choice tiles.
class _BorderPreview extends CustomPainter {
  _BorderPreview(this.b, this.main, this.soft);

  final BorderStyleOption b;
  final Color main;
  final Color soft;

  Paint _p(double w, Color c, {bool round = false}) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = w
    ..color = c
    ..strokeCap = round ? StrokeCap.round : StrokeCap.butt;

  Rect _r(Size s, double inset) =>
      Rect.fromLTWH(inset, inset, s.width - 2 * inset, s.height - 2 * inset);

  void _dashed(Canvas c, Path path, Paint p, double dash, double gap) {
    for (final PathMetric m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        c.drawPath(m.extractPath(d, d + dash), p);
        d += dash + gap;
      }
    }
  }

  @override
  void paint(Canvas c, Size s) {
    final k = 0.55; // preview chhota hai, isliye line patli
    switch (b.kind) {
      case BorderKind.none:
        break;
      case BorderKind.single:
      case BorderKind.thick:
        c.drawRect(_r(s, 4), _p(b.outerWidth * k, main));
        break;
      case BorderKind.doubleLine:
        c.drawRect(_r(s, 4), _p(b.outerWidth * k, main));
        c.drawRect(_r(s, 8), _p(b.innerWidth * k, main));
        break;
      case BorderKind.thinThick:
        c.drawRect(_r(s, 4), _p(b.outerWidth * k, main));
        c.drawRect(_r(s, 8), _p(b.innerWidth * k, soft));
        break;
      case BorderKind.dashed:
        _dashed(c, Path()..addRect(_r(s, 4)), _p(b.outerWidth * k, main), 4, 3);
        break;
      case BorderKind.dotted:
        _dashed(c, Path()..addRect(_r(s, 4)), _p(1.6, main, round: true), 0.1, 3.5);
        break;
      case BorderKind.rounded:
        c.drawRRect(RRect.fromRectAndRadius(_r(s, 4), const Radius.circular(8)),
            _p(b.outerWidth * k, main));
        break;
      case BorderKind.cornerBrackets:
        final r = _r(s, 4);
        final pp = _p(b.outerWidth * k, main);
        const l = 12.0;
        c.drawLine(r.topLeft, r.topLeft + const Offset(l, 0), pp);
        c.drawLine(r.topLeft, r.topLeft + const Offset(0, l), pp);
        c.drawLine(r.topRight, r.topRight + const Offset(-l, 0), pp);
        c.drawLine(r.topRight, r.topRight + const Offset(0, l), pp);
        c.drawLine(r.bottomLeft, r.bottomLeft + const Offset(l, 0), pp);
        c.drawLine(r.bottomLeft, r.bottomLeft + const Offset(0, -l), pp);
        c.drawLine(r.bottomRight, r.bottomRight + const Offset(-l, 0), pp);
        c.drawLine(r.bottomRight, r.bottomRight + const Offset(0, -l), pp);
        break;
      case BorderKind.ornamentCorners:
        final r = _r(s, 4);
        c.drawRect(r, _p(b.outerWidth * k, main));
        c.drawRect(_r(s, 8), _p(0.5, soft));
        final dot = Paint()..color = main;
        for (final o in [r.topLeft, r.topRight, r.bottomLeft, r.bottomRight]) {
          c.drawCircle(o, 2.4, dot);
        }
        break;
      case BorderKind.tripleLine:
        c.drawRect(_r(s, 3), _p(b.outerWidth * k, main));
        c.drawRect(_r(s, 6.5), _p(0.5, soft));
        c.drawRect(_r(s, 9), _p(0.6, main));
        break;
      case BorderKind.doubleRounded:
        c.drawRRect(RRect.fromRectAndRadius(_r(s, 4), const Radius.circular(8)),
            _p(b.outerWidth * k, main));
        c.drawRRect(RRect.fromRectAndRadius(_r(s, 8), const Radius.circular(5)),
            _p(0.5, soft));
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _BorderPreview old) =>
      old.b.id != b.id || old.main != main || old.soft != soft;
}
