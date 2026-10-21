import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'knowledge_pack.dart';
import 'numerology_engine.dart';
import 'numerology_tools.dart';

const List<String> _monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String _fmt(DateTime d) => '${d.day} ${_monthNames[d.month - 1]} ${d.year}';

/// Builds the printable report. Text is English only for now because the
/// built-in PDF fonts do not carry Devanagari; Hindi reports need a bundled
/// font and are a later step.
class ReportBuilder {
  static final PdfColor _gold = PdfColor.fromInt(0xFFB8860B);
  static final PdfColor _ink = PdfColor.fromInt(0xFF2B2418);

  static pw.Widget _h1(String text) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 18, bottom: 6),
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 17,
            fontWeight: pw.FontWeight.bold,
            color: _gold,
          ),
        ),
      );

  static pw.Widget _p(String text) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 6),
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 11.5, lineSpacing: 3, color: _ink),
        ),
      );

  static pw.Widget _labelled(String label, String text) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 7),
        child: pw.RichText(
          text: pw.TextSpan(
            style: pw.TextStyle(fontSize: 11.5, lineSpacing: 3, color: _ink),
            children: [
              pw.TextSpan(
                text: '$label: ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.TextSpan(text: text),
            ],
          ),
        ),
      );

  static List<pw.Widget> _compoundSection(String heading, NumerologyResult r) {
    final out = <pw.Widget>[
      _h1(heading),
      _p('Compound number ${r.total}, root number ${r.root} '
          '(${NumerologyTools.planetOf(r.root)}).'),
    ];
    final e = KnowledgePack.compoundEntry(r.total);
    if (e != null) {
      out.addAll([
        _labelled('Title', e.title),
        _labelled('Overview', e.summary),
        _labelled('Strengths', e.strengths),
        _labelled('Cautions', e.cautions),
        _labelled('Relationships', e.relationships),
        _labelled('Work', e.work),
        _labelled('Money', e.money),
        _labelled('Advice', e.advice),
      ]);
    } else {
      out.add(_p(r.compoundMeaning));
    }
    out.add(_labelled('Root ${r.root}', KnowledgePack.rootMeaning(r.root)));
    return out;
  }

  static pw.Document build({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
  }) {
    final birth = NumerologyEngine.birth(dob);
    final nameResult = NumerologyEngine.name(name);
    final now = DateTime.now();
    final psychic = birth.psychic.root;
    final destiny = birth.destiny.root;

    final widgets = <pw.Widget>[
      if (logo != null) ...[
        pw.Center(child: pw.Image(pw.MemoryImage(logo), height: 150)),
        pw.SizedBox(height: 10),
      ],
      pw.Center(
        child: pw.Text(
          'Ankdhara Numerology Report',
          style: pw.TextStyle(
            fontSize: 26,
            fontWeight: pw.FontWeight.bold,
            color: _gold,
          ),
        ),
      ),
      pw.SizedBox(height: 14),
      pw.Center(child: pw.Text(name, style: const pw.TextStyle(fontSize: 20))),
      pw.SizedBox(height: 4),
      pw.Center(child: pw.Text('Born ${_fmt(dob)}')),
      pw.SizedBox(height: 4),
      pw.Center(child: pw.Text('Prepared ${_fmt(now)}')),
      pw.Divider(color: _gold),
      _h1('Your core numbers'),
      _labelled('Psychic number',
          '$psychic (${NumerologyTools.planetOf(psychic)}). '
          '${KnowledgePack.rootMeaning(psychic)}'),
      _labelled('Destiny number',
          '$destiny (${NumerologyTools.planetOf(destiny)}). '
          '${KnowledgePack.rootMeaning(destiny)}'),
      _labelled('Birth date total',
          '${birth.destiny.total} (${birth.destiny.reductionChain.join(' > ')})'),
      ..._compoundSection('Destiny compound ${birth.destiny.total}', birth.destiny),
    ];

    if (nameResult.total > 0) {
      widgets.addAll(_compoundSection('Name analysis: $name', nameResult));
      final r1 = NumerologyTools.relation(nameResult.root, psychic);
      final r2 = NumerologyTools.relation(nameResult.root, destiny);
      widgets.add(_p(
        'Name root ${nameResult.root} with psychic $psychic: '
        '${NumerologyTools.relationLabel(r1)}. '
        'With destiny $destiny: ${NumerologyTools.relationLabel(r2)}.',
      ));
    }

    final mobileResult = NumerologyEngine.mobile(mobile);
    if (mobileResult.total > 0) {
      widgets.addAll(_compoundSection('Mobile number analysis', mobileResult));
      final r = NumerologyTools.relation(mobileResult.root, psychic);
      widgets.add(_p(
        'Mobile root ${mobileResult.root} with psychic $psychic: '
        '${NumerologyTools.relationLabel(r)}.',
      ));
    }

    widgets.add(_h1('Personal year cycle'));
    for (var y = now.year; y <= now.year + 1; y++) {
      final py = NumerologyTools.personalYear(dob, y);
      final t = NumerologyTools.yearThemes[py]!;
      widgets.add(_labelled('$y: Personal Year $py', '${t.title}. ${t.theme}'));
      widgets.add(_labelled('Focus', t.focus));
      widgets.add(_labelled('Be careful of', t.caution));
    }
    final months = StringBuffer();
    for (var m = 1; m <= 12; m++) {
      final pm = NumerologyTools.personalMonth(dob, now.year, m);
      months.write('${_monthNames[m - 1].substring(0, 3)} $pm');
      if (m < 12) months.write('   ');
    }
    widgets.add(_labelled('Personal months in ${now.year}', months.toString()));

    final rem = NumerologyTools.remedies[psychic];
    if (rem != null) {
      widgets.add(_h1('Supportive habits for number $psychic'));
      widgets.add(_labelled('Colours', rem.colours));
      widgets.add(_labelled('Favourable day', rem.day));
      widgets.add(_labelled('Gemstone (traditional)', rem.gemstone));
      widgets.add(_labelled('Metal', rem.metal));
      widgets.add(_labelled('Charity', rem.charity));
      widgets.add(_labelled('Daily practice', rem.practice));
    }

    widgets.addAll([
      _h1('Disclaimer and methodology'),
      _p('Numerology is a traditional interpretive system. This report uses '
          'the Chaldean letter values and the Cheiro compound series 10 to '
          '52. Interpretation texts are short paraphrases and modern '
          'guidance written for this app and are not quotations from any '
          'book. The report is for education and reflection and does not '
          'guarantee outcomes. It is not medical, legal or financial advice.'),
    ]);

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        footer: (ctx) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Ankdhara  |  @NikhilVGulatii',
                style: const pw.TextStyle(fontSize: 9)),
            pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}',
                style: const pw.TextStyle(fontSize: 9)),
          ],
        ),
        build: (_) => widgets,
      ),
    );
    return doc;
  }

  /// Opens the system print / save-as-PDF sheet with the full report.
  static Future<void> previewFull({
    required String name,
    required DateTime dob,
    String mobile = '',
  }) async {
    final doc = build(name: name, dob: dob, mobile: mobile);
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }

  /// Kept from Batch 1: one-page summary.
  static Future<void> preview({
    required String name,
    required String summary,
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (_) => pw.Column(
          children: [
            pw.Text(
              'Ankdhara Numerology',
              style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16),
            pw.Text(name, style: const pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Text(summary),
            pw.Spacer(),
            pw.Text('@NikhilVGulatii'),
          ],
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }
}
