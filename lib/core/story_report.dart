import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'knowledge_pack.dart';
import 'numerology_engine.dart';
import 'numerology_tools.dart';
import 'report_text.dart';
import 'root_profiles.dart';

/// Story style report in simple language. English or Hindi.
/// Hindi text is drawn with Flutter's own text engine and placed in the PDF
/// as pictures, so letters and matras always look correct.
class StoryReport {
  StoryReport._(this.hindi);

  final bool hindi;

  static const int _goldI = 0xFFB8860B;
  static const int _inkI = 0xFF2B2418;
  static const int _paperI = 0xFFFAF5E8;
  static const double _fullWidth = 520;
  static const double _boxWidth = 494;

  /// Builds the report. [years] is how many years of future predictions to
  /// include (starting from this year). Minimum 1, default 10.
  static Future<pw.Document> build({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
    bool hindi = false,
    int years = 10,
  }) {
    var n = years;
    if (n < 1) n = 1;
    if (n > 50) n = 50;
    return StoryReport._(hindi)._build(name, dob, mobile, logo, n);
  }

  /// Opens the print / save-as-PDF sheet.
  static Future<void> preview({
    required String name,
    required DateTime dob,
    String mobile = '',
    Uint8List? logo,
    bool hindi = false,
    int years = 10,
  }) async {
    final doc = await build(
      name: name,
      dob: dob,
      mobile: mobile,
      logo: logo,
      hindi: hindi,
      years: years,
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
  }) async {
    final doc = await build(
      name: name,
      dob: dob,
      mobile: mobile,
      logo: logo,
      hindi: hindi,
      years: years,
    );
    return doc.save();
  }

  // ---------------------------------------------------------------- text

  Future<pw.Widget> _text(
    String s, {
    double size = 11.5,
    bool bold = false,
    int color = _inkI,
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
          color: PdfColor.fromInt(color),
        ),
      );
    }
    const scale = 3.0;
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: 'NotoDeva',
          fontSize: size * scale,
          height: 1.55,
          fontWeight: bold ? ui.FontWeight.bold : ui.FontWeight.normal,
          color: ui.Color(color),
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
    return pw.Image(
      pw.MemoryImage(png),
      width: w / scale,
      height: h / scale,
    );
  }

  Future<pw.Widget> _h1(String s) async {
    return pw.Padding(
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
  }

  Future<pw.Widget> _p(String s) async {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child: await _text(s),
    );
  }

  pw.BoxDecoration _boxDeco() => pw.BoxDecoration(
        color: PdfColor.fromInt(_paperI),
        border: pw.Border.all(color: PdfColor.fromInt(_goldI), width: 0.6),
        borderRadius: pw.BorderRadius.circular(6),
      );

  Future<pw.Widget> _box(String title, String body) async {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 9),
      padding: const pw.EdgeInsets.all(11),
      decoration: _boxDeco(),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          await _text(title,
              size: 12.5, bold: true, color: _goldI, width: _boxWidth),
          pw.SizedBox(height: 4),
          await _text(body, width: _boxWidth),
        ],
      ),
    );
  }

  Future<pw.Widget> _facts(List<MapEntry<String, String>> rows) async {
    final kids = <pw.Widget>[];
    for (final r in rows) {
      kids.add(
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2.5),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 105,
                child: await _text(r.key, bold: true, width: 100),
              ),
              pw.Expanded(child: await _text(r.value, width: 380)),
            ],
          ),
        ),
      );
    }
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 9),
      padding: const pw.EdgeInsets.all(11),
      decoration: _boxDeco(),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: kids,
      ),
    );
  }

  Future<pw.Widget> _cell(String top, int n, String word) async {
    return pw.Container(
      width: 80,
      padding: const pw.EdgeInsets.all(6),
      decoration: _boxDeco(),
      child: pw.Column(
        children: [
          await _text(top, size: 9.5, bold: true, width: 68, center: true),
          await _text('$n',
              size: 16, bold: true, color: _goldI, width: 68, center: true),
          await _text(word, size: 9.5, width: 68, center: true),
        ],
      ),
    );
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
    out.add(await _box(totalLine, _relationLine(r.root, psychic, subject)));
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

  // --------------------------------------------------------------- build

  Future<pw.Document> _build(
    String name,
    DateTime dob,
    String mobile,
    Uint8List? logo,
    int years,
  ) async {
    final h = hindi;
    final birth = NumerologyEngine.birth(dob);
    final nameResult = NumerologyEngine.name(name);
    final mobileResult = NumerologyEngine.mobile(mobile);
    final now = DateTime.now();
    final psychic = birth.psychic.root;
    final destiny = birth.destiny.root;
    final pp = RootProfiles.of(psychic);
    final dp = RootProfiles.of(destiny);
    final hab = ReportText.habits[psychic];
    final w = <pw.Widget>[];

    // Cover
    if (logo != null) {
      w.add(pw.Center(child: pw.Image(pw.MemoryImage(logo), height: 140)));
      w.add(pw.SizedBox(height: 10));
    }
    w.add(await _text(ReportText.reportTitle.t(h),
        size: 26, bold: true, color: _goldI, center: true));
    w.add(pw.SizedBox(height: 12));
    w.add(await _text(name, size: 20, center: true));
    w.add(pw.SizedBox(height: 4));
    w.add(await _text('${ReportText.bornOn.t(h)}: ${_date(dob)}',
        center: true));
    w.add(pw.SizedBox(height: 2));
    w.add(await _text('${ReportText.preparedOn.t(h)}: ${_date(now)}',
        center: true));
    w.add(pw.SizedBox(height: 8));
    w.add(pw.Divider(color: PdfColor.fromInt(_goldI)));
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

    // Future years
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

    for (var y = first; y <= last; y++) {
      final py = NumerologyTools.personalYear(dob, y);
      final ys = ReportText.years[py] ?? ReportText.years[1]!;
      final ar = ReportText.yearAreas[py] ?? ReportText.yearAreas[1]!;
      w.add(await _box('$y  -  ${ys.title.t(h)}', ys.story.t(h)));
      w.add(await _facts([
        MapEntry(ReportText.careerTitle.t(h), ar.work.t(h)),
        MapEntry(ReportText.moneyTitle.t(h), ar.money.t(h)),
        MapEntry(ReportText.loveTitle.t(h), ar.love.t(h)),
        MapEntry(ReportText.doLabel.t(h), ys.doThis.t(h)),
        MapEntry(ReportText.takeCareLabel.t(h), ys.avoid.t(h)),
      ]));
    }

    // Months of this year
    w.add(await _h1(ReportText.monthsTitle.t(h)));
    w.add(await _p(ReportText.monthsIntro.t(h)));
    final months = <pw.Widget>[];
    final mn = h ? ReportText.monthsHi : ReportText.monthsEn;
    for (var m = 1; m <= 12; m++) {
      final pm = NumerologyTools.personalMonth(dob, now.year, m);
      final word = ReportText.monthWord[pm]?.t(h) ?? '';
      months.add(await _cell(mn[m - 1], pm, word));
    }
    w.add(pw.Wrap(spacing: 6, runSpacing: 6, children: months));
    w.add(pw.SizedBox(height: 10));

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

      // Action plan
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
    w.add(await _text(
      h ? RootProfiles.disclaimerHi : RootProfiles.disclaimer,
      size: 9,
    ));

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
        build: (_) => w,
      ),
    );
    return doc;
  }
}
