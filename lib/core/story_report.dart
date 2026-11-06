import 'month_details.dart';
import 'name_suggester.dart';
import 'name_texts.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'angel_numbers.dart';
import 'app_style.dart';
import 'extra_insights.dart' show NameScore;
import 'knowledge_pack.dart';
import 'lo_shu.dart';
import 'lo_shu_more.dart';
import 'lo_shu_text.dart';
import 'gemstone_guide.dart';
import 'health_guide.dart';
import 'heavy_numbers.dart';
import 'lucky_kit.dart';
import 'numerology_engine.dart';
// numerology_tools.dart also has a NameSuggestion class (baby names); the report
// uses the one from name_suggester.dart.
import 'numerology_tools.dart' hide NameSuggestion;
import 'pricing.dart';
import 'pythagorean.dart';
import 'signature_image.dart' show SignatureStore;
import 'signature_reading.dart';
import 'report_border.dart';
import 'report_options.dart';
import 'report_pages.dart';
import 'report_summary.dart';
import 'report_text.dart';
import 'root_profiles.dart';
import 'rudraksha_guide.dart';
import 'year_details.dart';

/// One picture of text (used for Hindi text and for the footer lines).
class _Img {
  final Uint8List png;
  final double w;
  final double h;
  const _Img(this.png, this.w, this.h);
}

/// Story style report in simple language. English or Hindi.
/// Hindi text is drawn with Flutter's own text engine and placed in the PDF
/// as pictures, so letters and matras always look correct.
///
/// Page order: cover, customer details, disclaimer, precautions and how to
/// read, then the report itself. Border, colours, language, years and the
/// footer lines come from [ReportOptions].
class StoryReport {
  StoryReport._(this.opts, this.sample);

  final ReportOptions opts;

  /// Free first report: shorter version with a sample mark.
  final bool sample;

  /// The spelling the customer chose in Name Correction (may be empty).
  String chosenName = '';
  String house = '';
  String vehicle = '';

  /// Safe mode: leaves out the name-suggestion section and the extra Lo Shu
  /// parts, used only when the full report could not be made.
  /// 0 = full report, 1 = no name suggestions or extra Lo Shu parts,
  /// 2 = also no summary page, 3 = also no Lo Shu section.
  int lite = 0;

  /// Headings; each one is kept on the same page as the widget after it.
  final Set<pw.Widget> _heads = <pw.Widget>{};

  bool get hindi => opts.hindi;
  int get _goldI => opts.palette.primary;
  int get _inkI => opts.palette.text;
  int get _paperI => opts.palette.tint;

  static const double _fullWidth = 500;
  static const double _boxWidth = 474;

  /// Builds the report. Pass [options] for the full set of choices. The old
  /// [hindi] and [years] are used only when [options] is not given.
  static Future<pw.Document> build({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
    bool hindi = false,
    int years = 10,
    ReportOptions? options,
    bool sample = false,
    String chosenName = '',
    int lite = 0,
    String house = '',
    String vehicle = '',
  }) {
    var base = options ?? ReportOptions(hindi: hindi, years: years);
    if (sample) base = base.copyWith(includeAngelNumbers: false);
    var n = base.years;
    if (sample && n > Pricing.sampleYears) n = Pricing.sampleYears;
    if (n < 1) n = 1;
    if (n > 50) n = 50;
    return (StoryReport._(base.copyWith(years: n), sample)
          ..chosenName = chosenName
          ..house = house
          ..vehicle = vehicle
          ..lite = lite)
        ._build(name, dob, mobile, logo);
  }

  /// Opens the print / save-as-PDF sheet.
  static Future<void> preview({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
    bool hindi = false,
    int years = 10,
    ReportOptions? options,
    bool sample = false,
    String chosenName = '',
    String house = '',
    String vehicle = '',
  }) async {
    final doc = await build(
      name: name,
      dob: dob,
      mobile: mobile,
      logo: logo,
      hindi: hindi,
      years: years,
      options: options,
      sample: sample,
      chosenName: chosenName,
      house: house,
      vehicle: vehicle,
    );
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }

  /// PDF bytes, for sharing.
  static Future<Uint8List> bytes({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
    bool hindi = false,
    int years = 10,
    ReportOptions? options,
    bool sample = false,
    String chosenName = '',
    String house = '',
    String vehicle = '',
  }) async {
    final doc = await build(
      name: name,
      dob: dob,
      mobile: mobile,
      logo: logo,
      hindi: hindi,
      years: years,
      options: options,
      sample: sample,
      chosenName: chosenName,
      house: house,
      vehicle: vehicle,
    );
    return doc.save();
  }

  // ---------------------------------------------------------------- text

  Future<_Img> _renderImage(
    String s, {
    double size = 11.5,
    bool bold = false,
    int? color,
    double width = _fullWidth,
    bool center = false,
  }) async {
    const scale = 3.0;
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: 'NotoDeva',
          fontSize: size * scale,
          height: 1.55,
          fontWeight: bold ? ui.FontWeight.bold : ui.FontWeight.normal,
          color: ui.Color(color ?? _inkI),
        ),
      ),
      textDirection: ui.TextDirection.ltr,
      textAlign: center ? ui.TextAlign.center : ui.TextAlign.left,
    );
    tp.layout(
      minWidth: center ? width * scale : 0,
      maxWidth: width * scale,
    );
    var w = tp.width.ceil();
    var h = tp.height.ceil();
    if (w < 1) w = 1;
    if (h < 1) h = 1;
    final rec = ui.PictureRecorder();
    final canvas = ui.Canvas(rec);
    tp.paint(canvas, ui.Offset.zero);
    final pic = rec.endRecording();
    final img = await pic.toImage(w, h);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    final png = data!.buffer.asUint8List();
    return _Img(png, w / scale, h / scale);
  }

  Future<pw.Widget> _text(
    String s, {
    double size = 11.5,
    bool bold = false,
    int? color,
    double width = _fullWidth,
    bool center = false,
  }) async {
    if (!hindi) {
      return pw.Text(
        s,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: size,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          lineSpacing: 3,
          color: PdfColor.fromInt(color ?? _inkI),
        ),
      );
    }
    final r = await _renderImage(s,
        size: size, bold: bold, color: color, width: width, center: center);
    return pw.Image(pw.MemoryImage(r.png), width: r.w, height: r.h);
  }

  Future<pw.Widget> _h1(String s) async {
    final hw = pw.Padding(
      padding: const pw.EdgeInsets.only(top: 16, bottom: 6),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          await _text(s, size: 17, bold: true, color: _goldI),
          pw.SizedBox(height: 3),
          pw.Container(height: 1.2, width: 60, color: PdfColor.fromInt(_goldI)),
        ],
      ),
    );
    _heads.add(hw);
    return hw;
  }

  /// Keeps every heading together with the widget that follows it, so a
  /// heading is never left alone at the bottom of a page.
  List<pw.Widget> _glue(List<pw.Widget> src) {
    final out = <pw.Widget>[];
    var i = 0;
    while (i < src.length) {
      final x = src[i];
      if (_heads.contains(x) && i + 1 < src.length) {
        out.add(pw.Inseparable(
          canSpan: false,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [x, src[i + 1]],
          ),
        ));
        i += 2;
      } else {
        out.add(x);
        i++;
      }
    }
    return out;
  }

  Future<pw.Widget> _p(String s) async {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child: await _text(s),
    );
  }

  /// Splits a long text at blank lines and adds each part as a paragraph.
  Future<List<pw.Widget>> _paras(String s) async {
    final out = <pw.Widget>[];
    for (final part in s.split('\n\n')) {
      final t = part.trim();
      if (t.isNotEmpty) out.add(await _p(t));
    }
    return out;
  }

  pw.BoxDecoration _boxDeco() => pw.BoxDecoration(
        color: PdfColor.fromInt(_paperI),
        border: pw.Border.all(color: PdfColor.fromInt(_goldI), width: 0.6),
        borderRadius: pw.BorderRadius.circular(6),
      );

  Future<pw.Widget> _box(
    String title,
    String body, {
    double size = 11.5,
    double pad = 11,
    double gap = 9,
  }) async {
    return pw.Inseparable(
      canSpan: false,
      child: pw.Container(
        margin: pw.EdgeInsets.only(bottom: gap),
        padding: pw.EdgeInsets.all(pad),
        decoration: _boxDeco(),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            await _text(title,
                size: size + 1, bold: true, color: _goldI, width: _boxWidth),
            pw.SizedBox(height: 4),
            await _text(body, size: size, width: _boxWidth),
          ],
        ),
      ),
    );
  }

  Future<pw.Widget> _facts(
    List<MapEntry<String, String>> rows, {
    double labelW = 105,
    double size = 11.5,
  }) async {
    final kids = <pw.Widget>[];
    for (final r in rows) {
      kids.add(
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2.5),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: labelW,
                child: await _text(r.key,
                    bold: true, size: size, width: labelW - 5),
              ),
              pw.Expanded(
                child: await _text(r.value,
                    size: size, width: _boxWidth - labelW - 4),
              ),
            ],
          ),
        ),
      );
    }
    return pw.Inseparable(
      canSpan: false,
      child: pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 9),
        padding: const pw.EdgeInsets.all(11),
        decoration: _boxDeco(),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: kids,
        ),
      ),
    );
  }

  Future<pw.Widget> _cell(String top, int n, String word) async {
    return pw.Container(
      width: 108,
      height: 80,
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      decoration: _boxDeco(),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          await _text(top, size: 9.5, bold: true, width: 98, center: true),
          await _text('$n',
              size: 16, bold: true, color: _goldI, width: 98, center: true),
          if (word.trim().isNotEmpty)
            await _text(word, size: 9.5, width: 98, center: true),
        ],
      ),
    );
  }



  // ------------------------------------------------------ name suggestions

  /// Better spellings of the name, each explained, plus how to choose.
  Future<List<pw.Widget>> _nameSuggestionSection(String name, DateTime dob) async {
    final h = hindi;
    final out = <pw.Widget>[];
    final r = NameSuggester.suggest(name, dob: dob);
    if (r == null) return out;
    final sc = r.originalScore;
    out.add(await _h1(NameTexts.title.t(h)));
    out.add(await _p(NameTexts.intro.t(h)));
    out.add(await _box(
      NameTexts.current.t(h),
      h
          ? '${r.original}: जोड़ ${r.originalTotal}, मूल अंक ${r.originalRoot}. परंपरागत व्याख्या: ${sc.label.of(true)} (धन ${sc.wealth}/100, भाग्य ${sc.luck}/100)। ${NameSuggester.scoreLine(r.originalPoints, true)}।'
          : '${r.original}: total ${r.originalTotal}, root ${r.originalRoot}. Traditional reading: ${sc.label.of(false)} (money ${sc.wealth}/100, luck ${sc.luck}/100). ${NameSuggester.scoreLine(r.originalPoints, false)}.',
    ));
    if (!r.anyBetter) out.add(await _p(NameTexts.noneBetter.t(h)));
    // Spellings with the same total read exactly the same, so they are
    // grouped and explained once.
    final groups = <int, List<NameSuggestion>>{};
    for (final x in r.items) {
      groups.putIfAbsent(x.total, () => <NameSuggestion>[]).add(x);
    }
    final limit = sample ? 3 : groups.length;
    var gi = 0;
    for (final list in groups.values) {
      if (gi >= limit) break;
      final s = list.first;
      final tag = s.better ? NameTexts.better.t(h) : NameTexts.similar.t(h);
      out.add(await _box(
          '${gi + 1}.  ${list.map((x) => x.name).join('   /   ')}  ($tag)',
          NameSuggester.explain(r, s, h)));
      final rows = NameSuggester.details(s, h);
      if (list.length > 1 && rows.isNotEmpty) {
        rows[0] = MapEntry(
            rows[0].key,
            list
                .map((x) => '${x.name}: ${x.changes.join(', ')}')
                .join('\n'));
      }
      out.add(await _facts(rows));
      gi++;
    }
    if (sample && groups.length > limit) {
      out.add(await _p(h
          ? 'पूरी रिपोर्ट में, जितनी उपयुक्त वर्तनियाँ मिलें (अधिकतम 20), हर एक विस्तार से दी जाती हैं।'
          : 'The full report gives every suitable spelling found (up to 20), each explained in detail.'));
    }
    if (chosenName.trim().isNotEmpty) {
      out.add(await _box(NameTexts.chosenTitle.t(h), chosenName.trim()));
    }
    out.add(await _box(NameTexts.chooseTitle.t(h), NameTexts.chooseBody.t(h)));
    out.add(await _box(NameTexts.cautionTitle.t(h), NameTexts.cautionBody.t(h)));
    out.add(await _p(NameTexts.method.t(h)));
    return out;
  }

  // ------------------------------------------------- lo shu and summary

  Future<pw.Widget> _loShuGrid(Map<int, int> c) async {
    pw.Widget cell(int n) {
      final k = c[n] ?? 0;
      return pw.Container(
        width: 64,
        height: 54,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          color: k > 0 ? PdfColor.fromInt(_paperI) : PdfColors.white,
          border: pw.Border.all(color: PdfColor.fromInt(_goldI), width: 0.8),
        ),
        child: pw.Text(
          k > 0 ? List.filled(k, '$n').join() : '-',
          style: pw.TextStyle(
            fontSize: k > 3 ? 14 : 18,
            fontWeight: pw.FontWeight.bold,
            color: k > 0 ? PdfColor.fromInt(_goldI) : PdfColors.grey500,
          ),
        ),
      );
    }

    return pw.Inseparable(
      canSpan: false,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              for (final row in LoShu.rows)
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [for (final n in row) cell(n)],
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// One page that sums up the whole report.
  Future<List<pw.Widget>> _summaryWidgets(
    String name,
    DateTime dob,
    int psychic,
    int destiny,
    RootProfile? pp,
  ) async {
    final h = hindi;
    final out = <pw.Widget>[];
    final c = LoShu.counts(dob);
    final missing = LoShu.missing(c);
    final lines = LoShu.completePlanes(c);
    out.add(await _h1(ReportSummary.title.t(h)));
    out.add(await _p(ReportSummary.intro.t(h)));
    out.add(await _loShuGrid(c));
    out.add(pw.SizedBox(height: 6));
    out.add(await _text(ReportSummary.gridCaption.t(h),
        size: 9.5, center: true, width: 440));
    out.add(pw.SizedBox(height: 12));

    final lucky = <int>{psychic, destiny}.toList()..sort();
    final ns = NameScore.of(name);
    final rows = <MapEntry<String, String>>[
      MapEntry(ReportSummary.luckyNumbers.t(h), lucky.join(', ')),
      if (pp != null) MapEntry(ReportSummary.luckyColours.t(h), pp.colours.t(h)),
      if (pp != null) MapEntry(ReportSummary.luckyDays.t(h), pp.luckyDays.t(h)),
      if (pp != null) MapEntry(ReportSummary.gemstone.t(h), pp.gemstone.t(h)),
      MapEntry(
        ReportSummary.missingNumbers.t(h),
        missing.isEmpty ? ReportSummary.none.t(h) : missing.join(', '),
      ),
      MapEntry(
        ReportSummary.strongLines.t(h),
        lines.isEmpty
            ? ReportSummary.none.t(h)
            : lines.map((i) => LoShuText.planeNames[i].t(h)).join(', '),
      ),
      if (ns != null)
        MapEntry(
          ReportSummary.nameGuide.t(h),
          h
              ? '${ns.compound} (${ns.root}) - ${ns.label.of(h)}; धन ${ns.wealth}/100, भाग्य ${ns.luck}/100'
              : '${ns.compound} (${ns.root}) - ${ns.label.of(h)}; money ${ns.wealth}/100, luck ${ns.luck}/100',
        ),
    ];
    out.add(await _facts(rows, labelW: 140, size: 11.5));
    out.add(await _p(ReportSummary.next.t(h)));
    return out;
  }

  /// The full Lo Shu section for the main report.
  Future<List<pw.Widget>> _loShuSection(DateTime dob) async {
    final h = hindi;
    final out = <pw.Widget>[];
    final c = LoShu.counts(dob);
    final missing = LoShu.missing(c);
    final lines = LoShu.completePlanes(c);
    out.add(await _h1(ReportSummary.loShuTitle.t(h)));
    out.add(await _p(ReportSummary.loShuIntro.t(h)));
    out.add(await _loShuGrid(c));
    out.add(pw.SizedBox(height: 6));
    out.add(await _p('${LoShuMore.usedFrom.t(h)}: ${LoShu.dateDigits(dob)}.  ${LoShuMore.usedAdded.t(h)}.'));

    out.add(await _h1(ReportSummary.haveTitle.t(h)));
    for (var n = 1; n <= 9; n++) {
      final k = c[n] ?? 0;
      if (k == 0) continue;
      final have = LoShuText.have[n];
      if (have == null) continue;
      final head = h
          ? '${ReportSummary.number.t(h)} $n  -  $k ${ReportSummary.times.t(h)} ${ReportSummary.appears.t(h)}'
          : '${ReportSummary.number.t(h)} $n  -  ${ReportSummary.appears.t(h)} $k ${ReportSummary.times.t(h)}';
      out.add(await _box(
        head,
        k > 1 ? '${have.t(h)}\n\n${ReportSummary.repeatNote.t(h)}' : have.t(h),
      ));
    }

    out.add(await _h1(ReportSummary.lackTitle.t(h)));
    if (missing.isEmpty) {
      out.add(await _p(ReportSummary.noMissing.t(h)));
    } else {
      for (final n in missing) {
        final lack = LoShuText.lack[n];
        if (lack == null) continue;
        out.add(await _box('${ReportSummary.number.t(h)} $n', lack.t(h)));
      }
    }

    if (lite > 0) {
      out.add(await _h1(ReportSummary.linesTitle.t(h)));
      if (lines.isEmpty) {
        out.add(await _p(ReportSummary.noLines.t(h)));
      } else {
        for (final i in lines) {
          out.add(await _box(LoShuText.planeNames[i].t(h), LoShuText.planeMeanings[i].t(h)));
        }
      }
      out.add(await _p(ReportSummary.loShuNote.t(h)));
      return out;
    }

    out.add(await _h1(LoShuMore.linesTitle.t(h)));
    out.add(await _p(LoShuMore.linesIntro.t(h)));
    for (var i = 0; i < LoShu.planes.length; i++) {
      final k = LoShu.lineCount(c, i);
      final word = h ? LoShuMore.stateWordHi[k] : LoShuMore.stateWordEn[k];
      final nums = LoShu.planes[i].join(' - ');
      final body = k == 3
          ? '${LoShuText.planeMeanings[i].t(h)}\n\n${LoShuMore.lineState[k].t(h)}'
          : LoShuMore.lineState[k].t(h);
      out.add(await _box(
          '${LoShuText.planeNames[i].t(h)}  ($nums)  -  $word', body));
    }
    if (lines.isEmpty) out.add(await _p(ReportSummary.noLines.t(h)));

    out.add(await _h1(LoShuMore.planesTitle.t(h)));
    out.add(await _p(LoShuMore.planesIntro.t(h)));
    for (var g = 0; g < 3; g++) {
      out.add(await _box(
          LoShuMore.groupNames[g].t(h),
          '${LoShuMore.groupMeaning[g].t(h)}\n\n'
          '${LoShuMore.groupLevel[LoShu.rowCount(c, g)].t(h)}'));
    }
    final dom = LoShu.dominantRow(c);
    out.add(await _p(
        dom < 0 ? LoShuMore.balanced.t(h) : LoShuMore.dominant[dom].t(h)));

    out.add(await _h1(LoShuMore.centreTitle.t(h)));
    out.add(await _p(
        (c[5] ?? 0) > 0 ? LoShuMore.centrePresent.t(h) : LoShuMore.centreAbsent.t(h)));

    final rep = LoShu.repeated(c);
    if (rep.isNotEmpty) {
      out.add(await _h1(LoShuMore.excessTitle.t(h)));
      for (final n in rep) {
        final e = LoShuMore.excess[n];
        if (e == null) continue;
        out.add(await _box(
            '${ReportSummary.number.t(h)} $n  -  ${c[n]} ${ReportSummary.times.t(h)}',
            e.t(h)));
      }
    }

    if (missing.isNotEmpty) {
      out.add(await _h1(LoShuMore.remedyTitle.t(h)));
      out.add(await _p(LoShuMore.remedyNote.t(h)));
      for (final n in missing) {
        final r = LoShuMore.remedy[n];
        if (r == null) continue;
        out.add(await _facts([
          MapEntry('${ReportSummary.number.t(h)} $n',
              '${LoShuMore.planetLabel.t(h)}: ${r.planet.t(h)}'),
          MapEntry(LoShuMore.dayLabel.t(h), r.day.t(h)),
          MapEntry(LoShuMore.colourLabel.t(h), r.colour.t(h)),
          MapEntry(LoShuMore.habitLabel.t(h), r.habit.t(h)),
        ], labelW: 125));
      }
    }

    out.add(await _p(ReportSummary.loShuNote.t(h)));
    return out;
  }

  // ------------------------------------------------------------- helpers

  String _date(DateTime d) {
    final m = hindi ? ReportText.monthsHi : ReportText.monthsEn;
    return '${d.day} ${m[d.month - 1]} ${d.year}';
  }

  String _relation(int a, int b) {
    final label =
        NumerologyTools.relationLabel(NumerologyTools.relation(a, b))
            .toString()
            .toLowerCase();
    if (label.contains('neutral')) return ReportText.relNeutral.t(hindi);
    if (label.contains('un') ||
        label.contains('enem') ||
        label.contains('hostile') ||
        label.contains('challeng') ||
        label.contains('oppos')) {
      return ReportText.relTense.t(hindi);
    }
    if (label.contains('friend') ||
        label.contains('harmon') ||
        label.contains('support')) {
      return ReportText.relFriendly.t(hindi);
    }
    return ReportText.relNeutral.t(hindi);
  }

  Future<List<pw.Widget>> _numberSection({
    required String title,
    required String intro,
    required NumerologyResult r,
    required int psychic,
    required String subject,
  }) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(title));
    out.add(await _p(intro));
    final totalLine = h
        ? '$subject का कुल अंक ${r.total} है, जो घटकर ${r.root} बनता है।'
        : 'The total for $subject is ${r.total}, which reduces to ${r.root}.';
    final heavy = HeavyNumbers.isHeavy(r.total);
    final relLine = _relationLine(r.root, psychic, subject);
    out.add(await _box(
      totalLine,
      heavy
          ? (h
              ? 'मूलांक के हिसाब से: $relLine'
              : 'By the root number: $relLine')
          : relLine,
    ));
    if (heavy) {
      out.add(await _box(
        h ? 'भारी अंक की सावधानी' : 'A heavy number: please read this',
        HeavyNumbers.note(r.total).t(h),
      ));
    }
    if (!h) {
      final e = KnowledgePack.compoundEntry(r.total);
      if (e != null) {
        out.add(await _h1(ReportText.compoundTitle.t(h)));
        out.add(await _box(e.title, e.summary));
        out.add(await _facts([
          MapEntry('Strengths', e.strengths),
          MapEntry('Be careful', e.cautions),
          MapEntry('Relationships', e.relationships),
          MapEntry('Work', e.work),
          MapEntry('Money', e.money),
          MapEntry('Advice', e.advice),
        ]));
      }
    }
    return out;
  }

  String _relationLine(int root, int psychic, String subject) {
    final rel = _relation(root, psychic);
    if (hindi) {
      return '$subject का अंक $root और आपका मूलांक $psychic: $rel';
    }
    return '$subject number $root with your birth number $psychic: $rel';
  }

  // --------------------------------------------------------- page pieces

  /// Black and white printouts get a grey version of the logo.
  Future<Uint8List> _gray(Uint8List png) async {
    try {
      final codec = await ui.instantiateImageCodec(png);
      final frame = await codec.getNextFrame();
      final img = frame.image;
      final rec = ui.PictureRecorder();
      final canvas = ui.Canvas(rec);
      final paint = ui.Paint()
        ..colorFilter = ui.ColorFilter.matrix(<double>[
          0.299, 0.587, 0.114, 0, 0, //
          0.299, 0.587, 0.114, 0, 0, //
          0.299, 0.587, 0.114, 0, 0, //
          0, 0, 0, 1, 0,
        ]);
      canvas.drawImage(img, ui.Offset.zero, paint);
      final out = await rec.endRecording().toImage(img.width, img.height);
      final data = await out.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } catch (_) {
      return png;
    }
  }

  pw.PageTheme _pageTheme() {
    final main = opts.blackWhite ? 0xFF000000 : opts.palette.primary;
    final soft = opts.blackWhite ? 0xFF666666 : opts.palette.accent;
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(46, 46, 46, 52),
      buildBackground: (ctx) => ReportBorder.background(opts.border, main, soft),
    );
  }

  Future<pw.Widget> _coverBody(String name, DateTime dob, Uint8List? logo) async {
    final h = hindi;
    final now = DateTime.now();
    final kids = <pw.Widget>[];
    if (logo != null) {
      kids.add(pw.Image(pw.MemoryImage(logo), height: 190));
      kids.add(pw.SizedBox(height: 28));
    }
    kids.add(await _text(ReportPages.coverKicker.t(h),
        size: 11.5, bold: true, color: _goldI, center: true));
    if (sample) {
      kids.add(pw.SizedBox(height: 4));
      kids.add(await _text(h ? 'फ्री सैंपल रिपोर्ट' : 'FREE SAMPLE REPORT',
          size: 11, bold: true, center: true));
    }
    kids.add(pw.SizedBox(height: 10));
    kids.add(await _text(ReportPages.coverTitle.t(h),
        size: 28, bold: true, color: _goldI, center: true, width: 440));
    kids.add(pw.SizedBox(height: 14));
    kids.add(pw.Container(
        width: 110, height: 2, color: PdfColor.fromInt(_goldI)));
    kids.add(pw.SizedBox(height: 28));
    kids.add(await _text(ReportPages.preparedFor.t(h), size: 12, center: true));
    kids.add(pw.SizedBox(height: 6));
    kids.add(await _text(name, size: 26, bold: true, center: true));
    kids.add(pw.SizedBox(height: 12));
    kids.add(await _text('${ReportText.bornOn.t(h)}: ${_date(dob)}',
        size: 13, center: true));
    kids.add(pw.SizedBox(height: 3));
    kids.add(await _text('${ReportText.preparedOn.t(h)}: ${_date(now)}',
        size: 13, center: true));
    kids.add(pw.SizedBox(height: 44));
    kids.add(await _text(ReportPages.coverTagline.t(h),
        size: 12, center: true, width: 400));
    return pw.Center(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: kids,
      ),
    );
  }

  Future<List<pw.Widget>> _customerWidgets({
    required String name,
    required DateTime dob,
    required String mobile,
    required int psychic,
    required int destiny,
    required String planet,
    required NumerologyResult nameResult,
    required NumerologyResult mobileResult,
    required bool hasWho,
  }) async {
    final h = hindi;
    final now = DateTime.now();
    final out = <pw.Widget>[];
    out.add(await _h1(ReportPages.customerTitle.t(h)));
    out.add(await _p(ReportPages.customerIntro.t(h)));

    final rows = <MapEntry<String, String>>[
      MapEntry(ReportPages.labelName.t(h), name),
      MapEntry(ReportPages.labelDob.t(h), _date(dob)),
      MapEntry(ReportPages.labelDay.t(h),
          (h ? ReportPages.weekHi : ReportPages.weekEn)[dob.weekday - 1]),
      MapEntry(ReportPages.labelMobile.t(h),
          mobile.trim().isEmpty ? ReportPages.notGiven.t(h) : mobile.trim()),
      if (house.trim().isNotEmpty)
        MapEntry(ReportPages.labelHouse.t(h), house.trim()),
      if (vehicle.trim().isNotEmpty)
        MapEntry(ReportPages.labelVehicle.t(h), vehicle.trim()),
      MapEntry(ReportPages.labelMulank.t(h), '$psychic'),
      MapEntry(ReportPages.labelBhagyank.t(h), '$destiny'),
      if (planet.isNotEmpty) MapEntry(ReportPages.labelPlanet.t(h), planet),
      if (nameResult.total > 0)
        MapEntry(ReportPages.labelNameNo.t(h),
            '${nameResult.total}  (${nameResult.root})'),
      if (mobileResult.total > 0)
        MapEntry(ReportPages.labelMobileNo.t(h),
            '${mobileResult.total}  (${mobileResult.root})'),
      MapEntry(ReportPages.labelLang.t(h),
          h ? ReportPages.langHindi.t(h) : ReportPages.langEnglish.t(h)),
      MapEntry(ReportPages.labelYears.t(h), '${opts.years}'),
      MapEntry(ReportPages.labelDate.t(h), _date(now)),
      MapEntry(ReportPages.labelBy.t(h), ReportPages.preparedByValue.t(h)),
    ];
    out.add(await _facts(rows, labelW: 165, size: 12.5));

    out.add(await _h1(ReportPages.glanceTitle.t(h)));
    final cells = <pw.Widget>[];
    cells.add(await _cell(h ? 'मूलांक' : 'Mulank', psychic, planet));
    cells.add(await _cell(h ? 'भाग्यांक' : 'Bhagyank', destiny, h ? 'भाग्य' : 'Destiny'));
    if (nameResult.total > 0) {
      cells.add(await _cell(h ? 'नाम' : 'Name', nameResult.root, '${nameResult.total}'));
    }
    if (mobileResult.total > 0) {
      cells.add(await _cell(h ? 'मोबाइल' : 'Mobile', mobileResult.root, '${mobileResult.total}'));
    }
    out.add(pw.Wrap(spacing: 6, runSpacing: 6, children: cells));
    out.add(pw.SizedBox(height: 10));

    out.add(await _h1(ReportPages.includesTitle.t(h)));
    final items = <String>[
      h ? 'आपके मुख्य अंक और उनका मतलब' : 'Your core numbers and what they mean',
      if (hasWho)
        h
            ? 'आप कौन हैं: स्वभाव, खूबियाँ, काम, पैसा, प्रेम और सेहत'
            : 'Who you are: personality, strengths, work, money, love and health',
      h ? 'एक पन्ने में आपकी रिपोर्ट और लो शू ग्रिड' : 'Your report in one page and your Lo Shu grid',
      if (nameResult.total > 0) h ? 'आपके नाम का विश्लेषण' : 'Name analysis',
      if (nameResult.total > 0)
        h ? 'आपके नाम के बेहतर वर्तनी-सुझाव' : 'Better spellings for your name',
      if (mobileResult.total > 0) h ? 'आपके मोबाइल नंबर का विश्लेषण' : 'Mobile number analysis',
      h
          ? 'आपके अगले ${opts.years} साल: सेहत, परिवार, सीखना और महीने-दर-महीने मार्गदर्शन'
          : 'Your next ${opts.years} years with health, family, learning and a month-by-month guide',
      h ? 'इस साल के पर्सनल मंथ' : 'Personal months of this year',
      h ? 'सरल उपाय' : 'Simple remedies',
      if (opts.includeAngelNumbers)
        h ? 'एंजल नंबर और आपकी जन्मतिथि' : 'Angel numbers and your date of birth',
      h ? 'कार्य योजना' : 'Action plan',
    ];
    for (final it in items) {
      out.add(pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: await _text('${h ? '•' : '-'}  $it', size: 11),
      ));
    }
    return out;
  }

  Future<List<pw.Widget>> _secPage(
    PBi title,
    PBi intro,
    List<Sec> secs,
  ) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(title.t(h)));
    out.add(await _p(intro.t(h)));
    for (final s in secs) {
      out.add(await _box(s.title.t(h), s.body.t(h),
          size: 10.5, pad: 9, gap: 6));
    }
    return out;
  }

  Future<List<pw.Widget>> _rudrakshaSection(int psychic, int destiny) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(RudrakshaGuide.title.t(h)));
    out.add(await _p(RudrakshaGuide.intro.t(h)));

    final shown = <int>{};
    Future<void> add(int root, String label) async {
      for (final m in RudrakshaGuide.forRoot[root] ?? const <int>[]) {
        final r = RudrakshaGuide.mukhis[m];
        if (r == null || !shown.add(m)) continue;
        out.add(await _box('$label: ${r.mukhi} ${RudrakshaGuide.mukhiLabel.t(h)}',
            '${RudrakshaGuide.deityLabel.t(h)}: ${r.deity.t(h)}'));
        out.add(await _facts([
          MapEntry(RudrakshaGuide.planetLabel.t(h), r.planet.t(h)),
          MapEntry(RudrakshaGuide.mantraLabel.t(h), r.mantra.t(h)),
          MapEntry(RudrakshaGuide.focusLabel.t(h), r.focus.t(h)),
          MapEntry(RudrakshaGuide.noteLabel.t(h), r.note.t(h)),
        ], labelW: 120));
      }
    }

    await add(psychic, RudrakshaGuide.forYou.t(h));
    await add(destiny, RudrakshaGuide.forYou2.t(h));
    out.add(await _box(RudrakshaGuide.universal.t(h), RudrakshaGuide.universalBody.t(h)));
    out.add(await _box(
      RudrakshaGuide.energiseTitle.t(h),
      RudrakshaGuide.energise.map((e) => e.t(h)).join('\n'),
    ));
    out.add(await _box(RudrakshaGuide.rulesTitle.t(h), RudrakshaGuide.rulesBody.t(h)));
    out.add(await _box(
      RudrakshaGuide.fakeTitle.t(h),
      RudrakshaGuide.fake.map((e) => '- ${e.t(h)}').join('\n'),
    ));
    out.add(await _p(RudrakshaGuide.safetyBody.t(h)));
    return out;
  }

  Future<List<pw.Widget>> _westernSection(String name, DateTime dob) async {
    final h = hindi;
    final c = Pythagorean.chart(dob, name);
    final out = <pw.Widget>[];
    out.add(await _h1(WesternText.title.t(h)));
    out.add(await _p(WesternText.intro.t(h)));
    String line(L lab, int n, L text, {int? raw}) {
      final r = (raw != null && raw != n) ? '$raw/$n' : '$n';
      return '${lab.t(h)}: $r. ${text.t(h)}';
    }

    final rows = <String>[
      line(WesternText.lifePath, c.lifePath, WesternText.core[c.lifePath]!, raw: c.lifePathRaw),
      line(WesternText.birthday, c.birthday, WesternText.core[c.birthday]!),
    ];
    if (c.expression != null) {
      rows.add(line(WesternText.expression, c.expression!, WesternText.core[c.expression!]!,
          raw: c.expressionRaw));
      if (c.soulUrge != null) {
        rows.add(line(WesternText.soul, c.soulUrge!, WesternText.inner[c.soulUrge!]!));
      }
      if (c.personality != null) {
        rows.add(line(WesternText.personality, c.personality!, WesternText.outer[c.personality!]!));
      }
      if (c.maturity != null) {
        rows.add(line(WesternText.maturity, c.maturity!, WesternText.core[c.maturity!]!));
      }
    }
    for (final r in rows) {
      out.add(await _p(r));
    }
    if (c.karmicDebts.isNotEmpty) {
      out.add(await _box(
        WesternText.karmicTitle.t(h),
        c.karmicDebts.map((k) => WesternText.karmicText[k]!.t(h)).join('\n'),
      ));
    }
    out.add(await _box(WesternText.eastWest.t(h), WesternText.eastWestBody.t(h)));
    return out;
  }

  Future<List<pw.Widget>> _healthSection(int psychic, int destiny) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(HealthGuide.title.t(h)));
    out.add(await _p(HealthGuide.intro.t(h)));
    final shown = <int>{};
    Future<void> add(int root, String head) async {
      final i = HealthGuide.byRoot[root];
      if (i == null || !shown.add(root)) return;
      out.add(await _box('$head: $root (${i.planet.t(h)})', i.areas.t(h)));
      out.add(await _facts([
        MapEntry(HealthGuide.watchLabel.t(h), i.watch.t(h)),
        MapEntry(HealthGuide.habitsLabel.t(h), i.habits.t(h)),
        MapEntry(HealthGuide.checkLabel.t(h), i.checkup.t(h)),
      ], labelW: 120));
    }

    await add(psychic, HealthGuide.mulankHead.t(h));
    await add(destiny, HealthGuide.bhagyankHead.t(h));
    out.add(await _box(HealthGuide.doctorTitle.t(h), HealthGuide.doctorBody.t(h)));
    return out;
  }

  Future<List<pw.Widget>> _precautionsSection() async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(HealthGuide.precTitle.t(h)));
    out.add(await _p(HealthGuide.precIntro.t(h)));
    out.add(await _box(
      HealthGuide.precTitle.t(h),
      HealthGuide.precautions.map((e) => '- ${e.t(h)}').join('\n'),
    ));
    return out;
  }

  Future<List<pw.Widget>> _signatureSection() async {
    final h = hindi;
    final photo = SignatureStore.photo;
    final reading = SignatureStore.reading;
    if (!SignatureStore.include || photo == null || reading is! SignatureReading) {
      return const [];
    }
    final out = <pw.Widget>[];
    out.add(await _h1(SignatureReading.pdfTitle.t(h)));
    out.add(await _p(SignatureReading.intro.t(h)));
    out.add(pw.Inseparable(
      canSpan: false,
      child: pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 10),
        padding: const pw.EdgeInsets.all(8),
        decoration: _boxDeco(),
        child: pw.Column(children: [
          await _text(SignatureReading.pdfPhoto.t(h) + (SignatureStore.name.isEmpty ? '' : ': ${SignatureStore.name}'),
              size: 11, bold: true, color: _goldI, width: _boxWidth),
          pw.SizedBox(height: 6),
          pw.Center(child: pw.Image(pw.MemoryImage(photo), height: 120, fit: pw.BoxFit.contain)),
        ]),
      ),
    ));
    for (final f in reading.findings) {
      out.add(await _box(
        f.title.t(h),
        '${SignatureReading.measuredLabel.t(h)}: ${f.measured}\n${f.reading.t(h)}\n${SignatureReading.tipLabel.t(h)}: ${f.tip.t(h)}',
      ));
    }
    final n = reading.number;
    if (n != null) {
      out.add(await _box(
        '${SignatureReading.numberHead.t(h)}: ${n.total}/${n.root}',
        SignatureReading.relationLine(n).t(h),
      ));
    }
    out.add(await _box(
      SignatureReading.improveHead.t(h),
      SignatureReading.improve.map((e) => '- ${e.t(h)}').join('\n'),
    ));
    out.add(await _p(SignatureReading.honest.t(h)));
    return out;
  }

  Future<List<pw.Widget>> _gemSection(int psychic, int destiny) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(GemstoneGuide.title.t(h)));
    out.add(await _p(GemstoneGuide.intro.t(h)));

    Future<void> stone(GemInfo g, String label) async {
      out.add(await _box(
        '$label: ${g.gem.t(h)}',
        '${GemstoneGuide.planetLabel.t(h)}: ${g.planet.t(h)}',
      ));
      out.add(await _facts([
        MapEntry(GemstoneGuide.substitute.t(h), g.alt.t(h)),
        MapEntry(GemstoneGuide.fingerLabel.t(h),
            GemstoneGuide.fingerNames[g.finger].t(h)),
        MapEntry(GemstoneGuide.metalLabel.t(h), g.metal.t(h)),
        MapEntry(GemstoneGuide.dayLabel.t(h), g.day.t(h)),
        MapEntry(GemstoneGuide.weightLabel.t(h), g.weight.t(h)),
        MapEntry(GemstoneGuide.mantraLabel.t(h), g.mantra.t(h)),
        MapEntry(GemstoneGuide.cautionLabel.t(h), g.caution.t(h)),
      ], labelW: 120));
    }

    final m = GemstoneGuide.gems[psychic];
    final b = GemstoneGuide.gems[destiny];
    if (m != null) await stone(m, GemstoneGuide.mainStone.t(h));
    if (b != null && m != null && b.root != m.root) {
      await stone(b, GemstoneGuide.secondStone.t(h));
    }

    out.add(await _box(GemstoneGuide.handTitle.t(h), GemstoneGuide.handBody.t(h)));
    out.add(await _box(GemstoneGuide.weightTitle.t(h), GemstoneGuide.weightIntro.t(h)));
    out.add(await _facts([
      for (final row in GemstoneGuide.ageTable) MapEntry(row[0].t(h), row[1].t(h)),
    ], labelW: 120));
    out.add(await _box(
      GemstoneGuide.stepsTitle.t(h),
      GemstoneGuide.steps.map((e) => e.t(h)).join('\n'),
    ));
    out.add(await _box(GemstoneGuide.buyTitle.t(h), GemstoneGuide.buyBody.t(h)));
    out.add(await _p(GemstoneGuide.safetyBody.t(h)));
    return out;
  }

  Future<List<pw.Widget>> _luckyKitSection(int psychic, int destiny) async {
    final h = hindi;
    final out = <pw.Widget>[];
    out.add(await _h1(LuckyKitText.title.t(h)));
    out.add(await _p(LuckyKitText.intro.t(h)));

    final picks = LuckyKit.luckyNumbers(psychic, destiny, count: 5);
    out.add(await _box(LuckyKitText.luckyTitle.t(h), LuckyKitText.luckyIntro.t(h)));
    out.add(await _facts([
      for (final k in picks)
        MapEntry(h ? 'अंक ${k.number}' : 'Number ${k.number}', k.why.t(h)),
    ]));
    final avoid = LuckyKit.avoidRoots(psychic, destiny);
    out.add(await _facts([
      MapEntry(
        LuckyKitText.avoidTitle.t(h),
        avoid.isEmpty
            ? LuckyKitText.avoidNone.t(h)
            : (h
                ? 'जिन नंबरों का जोड़ ${avoid.join(", ")} बनता है, उनसे बचना बेहतर माना जाता है।'
                : 'Numbers that add up to ${avoid.join(", ")} are traditionally better avoided.'),
      ),
    ]));

    final r = LuckyKit.house(house, psychic, destiny);
    if (r != null) {
      final info = LuckyKitText.home[r.root]!;
      out.add(await _h1(LuckyKitText.houseSection.t(h)));
      out.add(await _box(
        h
            ? 'आपका नंबर ${r.input}: कुल ${r.number.total}, मूलांक ${r.root}'
            : 'Your number ${r.input}: total ${r.number.total}, root ${r.root}',
        '${LuckyKitText.verdictTitle[r.verdict]!.t(h)}. '
            '${LuckyKitText.verdictBody[r.verdict]!.t(h)}',
      ));
      out.add(await _facts([
        MapEntry('${LuckyKitText.withMulank.t(h)} (${r.psychic})',
            LuckyKit.relWord(r.withPsychic, h)),
        MapEntry('${LuckyKitText.withBhagyank.t(h)} (${r.destiny})',
            LuckyKit.relWord(r.withDestiny, h)),
        MapEntry(LuckyKitText.homeNature.t(h), info.theme.t(h)),
        MapEntry(LuckyKitText.suitsLabel.t(h), info.suits.t(h)),
        MapEntry(LuckyKitText.watchLabel.t(h), info.watch.t(h)),
        MapEntry(LuckyKitText.tipLabel.t(h), info.tip.t(h)),
      ], labelW: 120));
      if (!h && r.number.hasCheiroCompound) {
        final e = KnowledgePack.compoundEntry(r.number.total);
        if (e != null) out.add(await _box('Compound ${r.number.total}: ${e.title}', e.summary));
      }
      if (r.verdict != HouseVerdict.good) {
        out.add(await _box(LuckyKitText.stepsTitle.t(h), LuckyKitText.steps.t(h)));
      }
    }
    out.add(await _p(LuckyKitText.note.t(h)));
    return out;
  }

  // --------------------------------------------------------------- build

  Future<pw.Document> _build(
    String name,
    DateTime dob,
    String mobile,
    Uint8List? logo0,
  ) async {
    final h = hindi;
    var logo = logo0;
    if (logo != null && opts.blackWhite) logo = await _gray(logo);

    final birth = NumerologyEngine.birth(dob);
    final nameResult = NumerologyEngine.name(name);
    final mobileResult = NumerologyEngine.mobile(mobile);
    final now = DateTime.now();
    final psychic = birth.psychic.root;
    final destiny = birth.destiny.root;
    final pp = RootProfiles.of(psychic);
    final dp = RootProfiles.of(destiny);
    final hab = ReportText.habits[psychic];
    final mn = h ? ReportText.monthsHi : ReportText.monthsEn;

    // Footer: the customer's own lines (no page number).
    final footerLines = <String>[...opts.footerLines];
    if (sample) {
      footerLines.add(h
          ? 'फ्री सैंपल रिपोर्ट - पूरी रिपोर्ट ऐप में मिलती है'
          : 'Free sample report - the full report is available in the app');
    }
    final footerItems = <Object>[];
    for (final line in footerLines) {
      final plain = !h && line.runes.every((r) => r < 256);
      footerItems.add(
          plain ? line : await _renderImage(line, size: 9, center: true));
    }
    pw.Widget footer(pw.Context ctx) {
      if (footerItems.isEmpty) {
        return pw.Center(
          child: pw.Text(
            'Ank Dhara',
            style: pw.TextStyle(fontSize: 9, color: PdfColor.fromInt(_inkI)),
          ),
        );
      }
      return pw.Center(
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            for (final it in footerItems)
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 2),
                child: it is _Img
                    ? pw.Image(pw.MemoryImage(it.png), width: it.w, height: it.h)
                    : pw.Text(
                        it as String,
                        style: pw.TextStyle(
                            fontSize: 9, color: PdfColor.fromInt(_inkI)),
                      ),
              ),
          ],
        ),
      );
    }

    final theme = _pageTheme();
    final doc = pw.Document();

    // 1. Cover page
    final cover = await _coverBody(name, dob, logo);
    doc.addPage(pw.Page(pageTheme: theme, build: (_) => cover));

    // 2. Customer details page
    final cust = await _customerWidgets(
      name: name,
      dob: dob,
      mobile: mobile,
      psychic: psychic,
      destiny: destiny,
      planet: pp?.planet.t(h) ?? '',
      nameResult: nameResult,
      mobileResult: mobileResult,
      hasWho: pp != null,
    );
    final custG = _glue(cust);
    doc.addPage(pw.MultiPage(
      pageTheme: theme,
      maxPages: 200,
      footer: footer,
      build: (_) => custG,
    ));

    // 2b. One page summary with the Lo Shu grid
    if (lite < 2) {
      final sumG = _glue(await _summaryWidgets(name, dob, psychic, destiny, pp));
      doc.addPage(pw.MultiPage(
        pageTheme: theme,
        maxPages: 200,
        footer: footer,
        build: (_) => sumG,
      ));
    }

    // 3. Notice, precautions and how to read (one flowing run of pages)
    final dis = await _secPage(
      ReportPages.noticeTitle,
      ReportPages.noticeIntro,
      ReportPages.notice,
    );
    dis.addAll(await _secPage(
      ReportPages.precautionsTitle,
      ReportPages.precautionsIntro,
      ReportPages.precautions,
    ));
    dis.addAll(await _secPage(
      ReportPages.readTitle,
      ReportPages.readIntro,
      ReportPages.read,
    ));
    final disG = _glue(dis);
    doc.addPage(pw.MultiPage(
      pageTheme: theme,
      maxPages: 200,
      footer: footer,
      build: (_) => disG,
    ));

    // 5. The report itself
    final w = <pw.Widget>[];
    w.add(await _box(ReportText.howTitle.t(h), ReportText.howBody.t(h)));

    // Two main numbers
    w.add(await _h1(ReportText.coreTitle.t(h)));
    w.add(await _box('${ReportText.psychicName.t(h)}: $psychic',
        ReportText.psychicWhat.t(h)));
    w.add(await _box('${ReportText.destinyName.t(h)}: $destiny',
        ReportText.destinyWhat.t(h)));
    if (psychic == destiny) {
      w.add(await _p(ReportText.sameNote.t(h)));
    }

    // Who you are
    if (pp != null) {
      w.add(await _h1('${ReportText.whoTitle.t(h)}: ${pp.title.t(h)}'));
      w.add(await _facts([
        MapEntry(ReportText.planetLabel.t(h), pp.planet.t(h)),
        MapEntry(ReportText.luckyDaysLabel.t(h), pp.luckyDays.t(h)),
        MapEntry(ReportText.coloursLabel.t(h), pp.colours.t(h)),
        MapEntry(ReportText.gemLabel.t(h), pp.gemstone.t(h)),
      ]));
      w.add(await _p(pp.overview.t(h)));
      w.add(await _p(pp.personality.t(h)));
      w.add(await _box(ReportText.strengthsTitle.t(h), pp.strengths.t(h)));
      w.add(await _box(ReportText.careTitle.t(h), pp.challenges.t(h)));
      w.add(await _h1(ReportText.lifeTitle.t(h)));
      w.add(await _box(ReportText.careerTitle.t(h), pp.career.t(h)));
      w.add(await _box(ReportText.moneyTitle.t(h), pp.money.t(h)));
      w.add(await _box(ReportText.loveTitle.t(h), pp.love.t(h)));
      w.add(await _box(ReportText.healthTitle.t(h), pp.health.t(h)));
      w.add(await _box(ReportText.adviceTitle.t(h), pp.advice.t(h)));
    }

    // Life road
    if (dp != null && destiny != psychic) {
      w.add(await _h1('${ReportText.roadTitle.t(h)}: ${dp.title.t(h)}'));
      w.add(await _p(dp.overview.t(h)));
      w.add(await _box(ReportText.careerTitle.t(h), dp.career.t(h)));
      w.add(await _box(ReportText.adviceTitle.t(h), dp.advice.t(h)));
    }

    // Lo Shu
    if (lite < 3) w.addAll(await _loShuSection(dob));

    // Name
    if (nameResult.total > 0) {
      w.addAll(await _numberSection(
        title: ReportText.nameTitle.t(h),
        intro: ReportText.nameIntro.t(h),
        r: nameResult,
        psychic: psychic,
        subject: h ? 'आपके नाम' : 'Your name',
      ));
    }

    // Better spellings of the name
    if (nameResult.total > 0 && lite == 0) {
      w.addAll(await _nameSuggestionSection(name, dob));
    }

    // Mobile
    if (mobileResult.total > 0) {
      w.addAll(await _numberSection(
        title: ReportText.mobileTitle.t(h),
        intro: ReportText.mobileIntro.t(h),
        r: mobileResult,
        psychic: psychic,
        subject: h ? 'आपके मोबाइल नंबर' : 'Your mobile number',
      ));
    }

    // Vehicle
    final vehicleResult = NumerologyEngine.vehicle(vehicle);
    if (vehicleResult.total > 0) {
      w.addAll(await _numberSection(
        title: ReportText.vehicleTitle.t(h),
        intro: ReportText.vehicleIntro.t(h),
        r: vehicleResult,
        psychic: psychic,
        subject: h ? 'आपकी गाड़ी का नंबर' : 'Your vehicle number',
      ));
    }

    // Future years
    final years = opts.years;
    final first = now.year;
    final last = now.year + years - 1;
    w.add(await _h1(h
        ? 'आपके अगले $years साल ($first - $last)'
        : 'Your next $years years ($first - $last)'));
    w.add(await _p(ReportText.yearsIntro.t(h)));
    if (years > 9) w.add(await _p(ReportText.cycleNote.t(h)));

    w.add(await _h1(ReportText.glanceTitle.t(h)));
    final glance = <pw.Widget>[];
    for (var y = first; y <= last; y++) {
      final py = NumerologyTools.personalYear(dob, y);
      final word = ReportText.years[py]?.title.t(h) ?? '';
      glance.add(await _cell('$y', py, word));
    }
    w.add(pw.Wrap(spacing: 6, runSpacing: 6, children: glance));
    w.add(pw.SizedBox(height: 10));

    // Months of this year (quick view)
    w.add(await _h1(ReportText.monthsTitle.t(h)));
    w.add(await _p(ReportText.monthsIntro.t(h)));
    final months = <pw.Widget>[];
    for (var m = 1; m <= 12; m++) {
      final pm = NumerologyTools.personalMonth(dob, now.year, m);
      final word = ReportText.monthWord[pm]?.t(h) ?? '';
      months.add(await _cell(mn[m - 1], pm, word));
    }
    w.add(pw.Wrap(spacing: 6, runSpacing: 6, children: months));
    w.add(pw.SizedBox(height: 10));


    for (var y = first; y <= last; y++) {
      final py = NumerologyTools.personalYear(dob, y);
      final ys = ReportText.years[py] ?? ReportText.years[1]!;
      final ar = ReportText.yearAreas[py] ?? ReportText.yearAreas[1]!;
      final ex = YearDetails.extra[py] ?? YearDetails.extra[1]!;
      w.add(await _box('$y  -  ${ys.title.t(h)}', ys.story.t(h)));
      w.add(await _facts([
        MapEntry(ReportText.careerTitle.t(h), ar.work.t(h)),
        MapEntry(ReportText.moneyTitle.t(h), ar.money.t(h)),
        MapEntry(ReportText.loveTitle.t(h), ar.love.t(h)),
        MapEntry(ReportPages.healthLabel.t(h), ex.health.t(h)),
        MapEntry(ReportPages.familyLabel.t(h), ex.family.t(h)),
        MapEntry(ReportPages.studyLabel.t(h), ex.study.t(h)),
        MapEntry(ReportPages.spiritLabel.t(h), ex.spirit.t(h)),
        MapEntry(ReportText.doLabel.t(h), ys.doThis.t(h)),
        MapEntry(ReportText.takeCareLabel.t(h), ys.avoid.t(h)),
      ]));
      if (y >= first + 2 && !sample) {
        // Later years: a short 12-month view only (no repeated long texts).
        w.add(await _h1('$y  -  ${ReportText.monthsTitle.t(h)}'));
        final mc = <pw.Widget>[];
        for (var m = 1; m <= 12; m++) {
          final pm = NumerologyTools.personalMonth(dob, y, m);
          mc.add(await _cell(mn[m - 1], pm, ReportText.monthWord[pm]?.t(h) ?? ''));
        }
        w.add(pw.Wrap(spacing: 6, runSpacing: 6, children: mc));
        w.add(pw.SizedBox(height: 10));
      } else if (!sample || y == first) {
        w.add(await _h1('$y  -  ${ReportPages.monthByMonth.t(h)}'));
        w.add(await _p(ReportPages.monthByMonthIntro.t(h)));
        for (var m = 1; m <= 12; m++) {
          final pm = NumerologyTools.personalMonth(dob, y, m);
          final md = MonthDetails.all[pm] ?? MonthDetails.all[1]!;
          w.add(await _box(
              '${mn[m - 1]} $y  -  ${MonthDetails.personalMonth.t(h)} $pm  (${md.word.t(h)})',
              md.story.t(h)));
          w.add(await _facts([
            MapEntry(MonthDetails.workLabel.t(h), md.work.t(h)),
            MapEntry(MonthDetails.loveLabel.t(h), md.love.t(h)),
            MapEntry(MonthDetails.healthLabel.t(h), md.health.t(h)),
            MapEntry(MonthDetails.tipLabel.t(h), md.tip.t(h)),
          ]));
        }
      }
    }

    // Simple remedies
    if (pp != null && hab != null) {
      w.add(await _h1(ReportText.remediesTitle.t(h)));
      w.add(await _p(ReportText.remediesIntro.t(h)));
      w.add(await _facts([
        MapEntry(ReportText.coloursLabel.t(h), pp.colours.t(h)),
        MapEntry(ReportText.luckyDaysLabel.t(h), pp.luckyDays.t(h)),
        MapEntry(ReportText.gemLabel.t(h), pp.gemstone.t(h)),
        MapEntry(ReportText.habitLabel.t(h), hab.habit.t(h)),
        MapEntry(ReportText.daanLabel.t(h), hab.daan.t(h)),
        MapEntry(ReportText.avoidLabel.t(h), hab.avoid.t(h)),
      ]));
    }

    // Signature analysis (only when the customer added it)
    if (lite < 2) {
      w.addAll(await _signatureSection());
    }

    // Health and precautions
    if (lite < 2) {
      w.addAll(await _healthSection(psychic, destiny));
      w.addAll(await _precautionsSection());
    }

    // Western (Pythagorean) chart
    if (lite < 2 && AppStyle.instance.showWestern) {
      w.addAll(await _westernSection(name, dob));
    }

    // Gemstone guide
    if (lite < 2) {
      w.addAll(await _gemSection(psychic, destiny));
    }

    // Lucky number kit and house number
    if (lite < 2) {
      w.addAll(await _rudrakshaSection(psychic, destiny));
      w.addAll(await _luckyKitSection(psychic, destiny));
    }

    // Angel numbers
    if (opts.includeAngelNumbers) {
      w.add(await _h1(AngelNumbers.introTitle(h)));
      w.addAll(await _paras(AngelNumbers.intro(h)));
      w.add(await _h1(AngelNumbers.dobTitle(h)));
      w.addAll(await _paras(AngelNumbers.dobGeneral(h)));
      w.add(await _h1(ReportPages.angelYourBirth.t(h)));
      w.addAll(await _paras(AngelNumbers.dobParagraph(dob, now.year, h)));
      w.add(await _h1(ReportPages.angelAll.t(h)));
      w.add(await _p(ReportPages.angelAllIntro.t(h)));
      final links = AngelNumbers.linksForDob(dob, now.year);
      for (final l in links) {
        final a = l.angel;
        w.add(await _box('${a.number}  -  ${a.title(h)}',
            '${l.label(h)}: ${l.reason(h)}'));
        w.add(await _facts([
          MapEntry(ReportPages.angelMeaning.t(h), a.meaning(h)),
          MapEntry(ReportPages.angelMessage.t(h), a.message(h)),
          MapEntry(ReportPages.angelLove.t(h), a.love(h)),
          MapEntry(ReportPages.angelCareer.t(h), a.career(h)),
          MapEntry(ReportPages.angelStep.t(h), a.action(h)),
        ]));
      }
    }

    // Action plan
    if (pp != null && hab != null) {
      final ys = ReportText.years[NumerologyTools.personalYear(dob, now.year)] ??
          ReportText.years[1]!;
      w.add(await _h1(ReportText.actionTitle.t(h)));
      w.add(await _p(ReportText.actionIntro.t(h)));
      w.add(await _box('1.  ${ReportText.actAdvice.t(h)}', pp.advice.t(h)));
      w.add(await _box('2.  ${ReportText.actHabit.t(h)}', hab.habit.t(h)));
      w.add(await _box('3.  ${ReportText.actYear.t(h)}', ys.doThis.t(h)));
      w.add(await _box('4.  ${ReportText.actCare.t(h)}', hab.avoid.t(h)));
      w.add(await _box(
        '5.  ${ReportText.actDay.t(h)}',
        h
            ? 'अपने शुभ दिनों (${pp.luckyDays.t(h)}) में कोई ज़रूरी काम शुरू करने की कोशिश करें।'
            : 'Try to begin one important task on your lucky days (${pp.luckyDays.t(h)}).',
      ));
    }

    // Closing
    w.add(await _h1(ReportText.closingTitle.t(h)));
    w.add(await _p(ReportText.closingBody.t(h)));
    if (sample) {
      w.add(await _box(
        h ? 'पूरी रिपोर्ट में और क्या मिलता है' : 'What the full report adds',
        h
            ? 'पूरी रिपोर्ट में आपके चुने हुए सभी आगे के साल, हर साल के लिए महीने-दर-महीने मार्गदर्शन और एंजल नंबर वाला पूरा हिस्सा मिलता है।'
            : 'The full report gives all the future years you choose, a month-by-month guide for every year and the complete angel numbers section.',
      ));
    }
    // The disclaimer and precautions are now at the front of the report.
    w.add(await _text(
      h
          ? 'ज़रूरी सूचना और सावधानियाँ इस रिपोर्ट की शुरुआत के पन्नों में दी गई हैं।'
          : 'The notice and precautions are given on the first pages of this report.',
      size: 9,
    ));

    final wG = _glue(w);
    doc.addPage(pw.MultiPage(
      pageTheme: theme,
      maxPages: 200,
      footer: footer,
      build: (_) => wG,
    ));
    return doc;
  }
}
