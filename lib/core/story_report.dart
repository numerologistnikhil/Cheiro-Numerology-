import 'month_details.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'angel_numbers.dart';
import 'knowledge_pack.dart';
import 'numerology_engine.dart';
import 'numerology_tools.dart';
import 'pricing.dart';
import 'report_border.dart';
import 'report_options.dart';
import 'report_pages.dart';
import 'report_text.dart';
import 'root_profiles.dart';
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
  }) {
    var base = options ?? ReportOptions(hindi: hindi, years: years);
    if (sample) base = base.copyWith(includeAngelNumbers: false);
    var n = base.years;
    if (sample && n > Pricing.sampleYears) n = Pricing.sampleYears;
    if (n < 1) n = 1;
    if (n > 50) n = 50;
    return StoryReport._(base.copyWith(years: n), sample)
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
      if (nameResult.total > 0) h ? 'आपके नाम का विश्लेषण' : 'Name analysis',
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
      if (!sample || y == first) {
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
