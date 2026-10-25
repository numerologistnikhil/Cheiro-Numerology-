// Ank Dhara - PDF Report Options
// Pure Dart (Flutter ki zarurat nahi). Rang int (0xAARRGGBB) me hain.
// Ye file sirf "options ka dimaag" hai: 12 border, 12 colour combination,
// black-white / colourful, bhasha, aur har page ka neeche wala footer.

enum BorderKind { none, single, thick, doubleLine, thinThick, dashed, dotted, rounded, cornerBrackets, ornamentCorners, tripleLine, doubleRounded }

class BorderStyleOption {
  final int id;
  final String nameEn, nameHi;
  final BorderKind kind;
  final double outerWidth; // point me
  final double innerWidth; // 0 = andar ki line nahi
  final double gap; // bahar aur andar ki line ke beech
  final double radius; // 0 = seedhe kone
  const BorderStyleOption(this.id, this.nameEn, this.nameHi, this.kind,
      {this.outerWidth = 1.0, this.innerWidth = 0, this.gap = 0, this.radius = 0});

  String name(bool hi) => hi ? nameHi : nameEn;
}

class PaletteOption {
  final int id;
  final String nameEn, nameHi;
  final int primary; // heading, border
  final int accent; // chhoti lines, chips
  final int tint; // halka background
  final int text; // body text
  const PaletteOption(this.id, this.nameEn, this.nameHi, this.primary, this.accent, this.tint, this.text);

  String name(bool hi) => hi ? nameHi : nameEn;
}

class ReportOptions {
  // ---------- 12 border styles ----------
  static const List<BorderStyleOption> borders = [
    BorderStyleOption(0, 'No Border', 'कोई बॉर्डर नहीं', BorderKind.none),
    BorderStyleOption(1, 'Thin Line', 'पतली लाइन', BorderKind.single, outerWidth: 0.8),
    BorderStyleOption(2, 'Bold Line', 'मोटी लाइन', BorderKind.thick, outerWidth: 3.0),
    BorderStyleOption(3, 'Double Line', 'दोहरी लाइन', BorderKind.doubleLine, outerWidth: 1.2, innerWidth: 1.2, gap: 4),
    BorderStyleOption(4, 'Thick + Thin', 'मोटी + पतली लाइन', BorderKind.thinThick, outerWidth: 3.0, innerWidth: 0.8, gap: 3),
    BorderStyleOption(5, 'Dashed', 'डैश वाली', BorderKind.dashed, outerWidth: 1.5),
    BorderStyleOption(6, 'Dotted', 'बिंदुओं वाली', BorderKind.dotted, outerWidth: 2.0),
    BorderStyleOption(7, 'Rounded Corners', 'गोल कोने', BorderKind.rounded, outerWidth: 1.5, radius: 14),
    BorderStyleOption(8, 'Corner Brackets', 'कोनों पर ब्रैकेट', BorderKind.cornerBrackets, outerWidth: 2.5),
    BorderStyleOption(9, 'Ornament Corners', 'सजावटी कोने', BorderKind.ornamentCorners, outerWidth: 1.5, innerWidth: 0.6, gap: 3),
    BorderStyleOption(10, 'Triple Line', 'तीन लाइन', BorderKind.tripleLine, outerWidth: 2.0, innerWidth: 0.8, gap: 3),
    BorderStyleOption(11, 'Royal Rounded Double', 'शाही गोल दोहरी', BorderKind.doubleRounded, outerWidth: 2.0, innerWidth: 0.8, gap: 4, radius: 12),
  ];

  // ---------- 12 colour combinations ----------
  static const List<PaletteOption> palettes = [
    PaletteOption(0, 'Classic Gold', 'क्लासिक गोल्ड', 0xFFB8860B, 0xFFE6C36A, 0xFFFFF8E7, 0xFF3B2F1E),
    PaletteOption(1, 'Royal Blue', 'रॉयल ब्लू', 0xFF1F3A93, 0xFF6C8EE8, 0xFFEEF3FF, 0xFF1B2540),
    PaletteOption(2, 'Emerald Green', 'एमरल्ड ग्रीन', 0xFF0B6E4F, 0xFF5CC49A, 0xFFEAF8F2, 0xFF12302A),
    PaletteOption(3, 'Rose Pink', 'रोज़ पिंक', 0xFFC2185B, 0xFFF48FB1, 0xFFFFEEF4, 0xFF3A1A27),
    PaletteOption(4, 'Deep Maroon', 'गहरा मरून', 0xFF7B1E2B, 0xFFD98B6A, 0xFFFFF1EC, 0xFF35161B),
    PaletteOption(5, 'Saffron Orange', 'केसरिया', 0xFFE65100, 0xFFFFB74D, 0xFFFFF3E5, 0xFF40220E),
    PaletteOption(6, 'Mystic Purple', 'मिस्टिक पर्पल', 0xFF5E35B1, 0xFFB39DDB, 0xFFF3EEFB, 0xFF271A47),
    PaletteOption(7, 'Ocean Teal', 'ओशन टील', 0xFF00796B, 0xFF4DB6AC, 0xFFE6F6F4, 0xFF0F2D2A),
    PaletteOption(8, 'Sunset Coral', 'सनसेट कोरल', 0xFFD84315, 0xFFFF8A65, 0xFFFFEFEA, 0xFF3D1D14),
    PaletteOption(9, 'Midnight Navy', 'मिडनाइट नेवी', 0xFF14213D, 0xFFFCA311, 0xFFF1F3F8, 0xFF0F172A),
    PaletteOption(10, 'Lavender Dream', 'लैवेंडर ड्रीम', 0xFF7E57C2, 0xFFD1C4E9, 0xFFF8F5FF, 0xFF2D2347),
    PaletteOption(11, 'Earth Brown', 'अर्थ ब्राउन', 0xFF6D4C41, 0xFFBCAAA4, 0xFFF7F1EE, 0xFF2E211C),
  ];

  // Black & white ke liye fixed palette (printout me sirf kaala/grey/safed)
  static const PaletteOption blackWhitePalette =
      PaletteOption(99, 'Black & White', 'ब्लैक एंड व्हाइट', 0xFF000000, 0xFF666666, 0xFFFFFFFF, 0xFF111111);

  // ---------- Choices ----------
  final bool hindi;
  final int borderId;
  final int paletteId;
  final bool blackWhite;
  final String footerLine1;
  final String footerLine2;
  final int years; // kitne saal ki prediction (app me customer chunega)
  final bool includeAngelNumbers;

  const ReportOptions({
    this.hindi = false,
    this.borderId = 3,
    this.paletteId = 0,
    this.blackWhite = false,
    this.footerLine1 = '',
    this.footerLine2 = '',
    this.years = 10,
    this.includeAngelNumbers = true,
  });

  static const int maxFooterChars = 90;

  static String cleanFooter(String s) {
    final t = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return t.length > maxFooterChars ? t.substring(0, maxFooterChars) : t;
  }

  BorderStyleOption get border =>
      borders.firstWhere((b) => b.id == borderId, orElse: () => borders[3]);

  /// Printout me jo palette sach me use hoga (B/W chuna ho to wahi).
  PaletteOption get palette => blackWhite
      ? blackWhitePalette
      : palettes.firstWhere((p) => p.id == paletteId, orElse: () => palettes[0]);

  bool get hasFooter => footerLine1.trim().isNotEmpty || footerLine2.trim().isNotEmpty;

  List<String> get footerLines => [cleanFooter(footerLine1), cleanFooter(footerLine2)]
      .where((s) => s.isNotEmpty)
      .toList();

  ReportOptions copyWith({
    bool? hindi,
    int? borderId,
    int? paletteId,
    bool? blackWhite,
    String? footerLine1,
    String? footerLine2,
    int? years,
    bool? includeAngelNumbers,
  }) {
    return ReportOptions(
      hindi: hindi ?? this.hindi,
      borderId: borderId ?? this.borderId,
      paletteId: paletteId ?? this.paletteId,
      blackWhite: blackWhite ?? this.blackWhite,
      footerLine1: footerLine1 ?? this.footerLine1,
      footerLine2: footerLine2 ?? this.footerLine2,
      years: years ?? this.years,
      includeAngelNumbers: includeAngelNumbers ?? this.includeAngelNumbers,
    );
  }

  Map<String, dynamic> toJson() => {
        'hindi': hindi,
        'borderId': borderId,
        'paletteId': paletteId,
        'blackWhite': blackWhite,
        'footerLine1': footerLine1,
        'footerLine2': footerLine2,
        'years': years,
        'includeAngelNumbers': includeAngelNumbers,
      };

  factory ReportOptions.fromJson(Map<String, dynamic> j) => ReportOptions(
        hindi: j['hindi'] == true,
        borderId: (j['borderId'] as int?) ?? 3,
        paletteId: (j['paletteId'] as int?) ?? 0,
        blackWhite: j['blackWhite'] == true,
        footerLine1: (j['footerLine1'] as String?) ?? '',
        footerLine2: (j['footerLine2'] as String?) ?? '',
        years: (j['years'] as int?) ?? 10,
        includeAngelNumbers: j['includeAngelNumbers'] != false,
      );
}
