import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/lo_shu.dart';
import '../core/lo_shu_more.dart';
import '../core/numerology_engine.dart';
import '../core/root_profiles.dart' show L;
import 'ui_kit.dart';

/// Names of the eight lines, in the same order as [LoShu.planes].
const List<L> _planeNames = [
  L('Mental line', 'सोच की रेखा'),
  L('Emotional line', 'भावना की रेखा'),
  L('Practical line', 'व्यावहारिक रेखा'),
  L('Thought line', 'विचार की रेखा'),
  L('Willpower line', 'इच्छा-शक्ति की रेखा'),
  L('Action line', 'कर्म की रेखा'),
  L('Determination line', 'दृढ़ता की रेखा'),
  L('Inner balance line', 'आंतरिक संतुलन की रेखा'),
];

const List<L> _planeMeanings = [
  L('Strong thinking, memory and planning.',
      'सोचने, याददाश्त और योजना बनाने की अच्छी शक्ति।'),
  L('Feelings, intuition and creativity flow easily.',
      'भावनाएँ, अंतर्ज्ञान और रचनात्मकता सहज रूप से बहती हैं।'),
  L('Good at turning plans into results, and at handling money and daily work.',
      'योजनाओं को नतीजों में बदलने और पैसे व रोज़ के काम सँभालने में अच्छे।'),
  L('You think clearly and can organise your ideas.',
      'आप साफ़ सोचते हैं और विचारों को सलीक़े से सजा लेते हैं।'),
  L('Strong will; you can stay with a goal.',
      'इच्छा-शक्ति मज़बूत; आप लक्ष्य पर टिके रह सकते हैं।'),
  L('You turn feelings and intuition into action.',
      'आप भावना और अंतर्ज्ञान को कर्म में बदल लेते हैं।'),
  L('Steady and determined; you finish what you start.',
      'स्थिर और दृढ़; जो शुरू करते हैं उसे पूरा करते हैं।'),
  L('Calm, balanced and patient in hard times.',
      'कठिन समय में शांत, संतुलित और धैर्यवान।'),
];

/// What a number gives when it is present.
const Map<int, L> _have = {
  1: L('Self-confidence, leadership and a clear voice.',
      'आत्मविश्वास, नेतृत्व और अपनी बात साफ़ कहने की ताक़त।'),
  2: L('Sensitivity, cooperation and good intuition.',
      'संवेदनशीलता, सहयोग और अच्छा अंतर्ज्ञान।'),
  3: L('Creativity, learning and the joy of expression.',
      'रचनात्मकता, सीखने की ललक और अपनी बात कहने का आनंद।'),
  4: L('Discipline, order and practical hard work.',
      'अनुशासन, व्यवस्था और व्यावहारिक मेहनत।'),
  5: L('Balance, communication and the ability to adapt.',
      'संतुलन, संवाद और ख़ुद को ढाल लेने की क्षमता।'),
  6: L('Care for family, and love of comfort and beauty.',
      'परिवार की परवाह, आराम और सुंदरता से प्रेम।'),
  7: L('Depth, analysis and spiritual interest.',
      'गहराई, विश्लेषण और आध्यात्मिक रुचि।'),
  8: L('Responsibility, money sense and patience.',
      'ज़िम्मेदारी, पैसे की समझ और धैर्य।'),
  9: L('Energy, courage and a wish to serve others.',
      'ऊर्जा, साहस और दूसरों की सेवा की इच्छा।'),
};

/// A gentle tip when a number is missing.
const Map<int, L> _lack = {
  1: L('You may hold back from speaking up. Practise giving your opinion '
      'early and take small steps to lead.',
      'आप अपनी बात कहने से हिचक सकते हैं। अपनी राय जल्दी रखने और '
      'छोटे-छोटे नेतृत्व के कदम उठाने का अभ्यास करें।'),
  2: L('Patience in relationships may be harder. Practise listening and give '
      'feelings a little time.',
      'रिश्तों में धैर्य थोड़ा कठिन लग सकता है। सुनने का अभ्यास करें और '
      'भावनाओं को थोड़ा समय दें।'),
  3: L('Showing feelings may take effort. Writing, singing or talking with a '
      'friend can help.',
      'भावनाएँ जताना मेहनत माँग सकता है। लिखना, गाना या दोस्त से बात करना '
      'मदद करता है।'),
  4: L('Routine and planning may need effort. A simple daily list and fixed '
      'timings help.',
      'दिनचर्या और योजना में मेहनत लग सकती है। रोज़ की एक सरल सूची और '
      'तय समय मदद करते हैं।'),
  5: L('Balance and quick decisions may need effort. Keep a steady routine '
      'and think before big choices.',
      'संतुलन और जल्दी फैसले लेने में मेहनत लग सकती है। नियमित दिनचर्या रखें '
      'और बड़े फैसलों से पहले सोचें।'),
  6: L('Home and family comfort may need extra attention. Spend small, '
      'regular time with loved ones.',
      'घर और परिवार के सुकून पर अतिरिक्त ध्यान देना पड़ सकता है। अपनों के साथ '
      'थोड़ा-थोड़ा नियमित समय बिताएँ।'),
  7: L('Quiet reflection may be rare. A few minutes of silence or a short walk '
      'each day helps.',
      'शांत चिंतन कम मिल पाता है। रोज़ कुछ मिनट मौन या छोटी सैर मदद करती है।'),
  8: L('Money planning and patience may need effort. Save a fixed small '
      'amount each month.',
      'पैसे की योजना और धैर्य में मेहनत लग सकती है। हर महीने एक तय छोटी रक़म '
      'बचाएँ।'),
  9: L('Staying energetic for long goals may be hard. Light daily exercise and '
      'helping others restore energy.',
      'लंबे लक्ष्यों के लिए ऊर्जा बनाए रखना कठिन हो सकता है। रोज़ हल्का व्यायाम '
      'और दूसरों की मदद ऊर्जा लौटाती है।'),
};

class LoShuScreen extends StatefulWidget {
  const LoShuScreen({super.key});

  @override
  State<LoShuScreen> createState() => _LoShuScreenState();
}

class _LoShuScreenState extends State<LoShuScreen> {
  // Same key as Daily Lucky, so the date is remembered across both screens.
  static const _kDob = 'daily_lucky_dob';
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final p = await SharedPreferences.getInstance();
      final ms = p.getInt(_kDob);
      if (ms != null && mounted) {
        setState(() => _dob = DateTime.fromMillisecondsSinceEpoch(ms));
      }
    } catch (_) {
      // Remembering the date is optional.
    }
  }

  Future<void> _save(DateTime d) async {
    setState(() => _dob = d);
    try {
      final p = await SharedPreferences.getInstance();
      await p.setInt(_kDob, d.millisecondsSinceEpoch);
    } catch (_) {
      // Remembering the date is optional.
    }
  }

  Widget _cell(int n, int count) {
    final has = count > 0;
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: has ? const Color(0x47D4AF37) : AnkdharaColors.cream,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: has ? AnkdharaColors.gold : AnkdharaColors.goldLine,
              width: has ? 1.6 : 1,
            ),
          ),
          child: has
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      List.filled(count, '$n').join(' '),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AnkdharaColors.ink,
                      ),
                    ),
                  ),
                )
              : Text(
                  '$n',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0x55B8860B),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _grid(Map<int, int> c) {
    return Column(
      children: [
        for (final row in LoShu.rows)
          Row(
            children: [for (final n in row) _cell(n, c[n] ?? 0)],
          ),
      ],
    );
  }

  Widget _numCard(String label, int n) {
    return Expanded(
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            NumberBadge(n, size: 48),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _result(AppSettings s, DateTime dob) {
    final birth = NumerologyEngine.birth(dob);
    final c = LoShu.counts(dob);
    final missing = LoShu.missing(c);
    final heavy = c.values.any((v) => v >= 4);

    return [
      const SizedBox(height: 16),
      Row(
        children: [
          _numCard(s.t(const L('Psychic number', 'मूलांक')), birth.psychic.root),
          const SizedBox(width: 12),
          _numCard(s.t(const L('Destiny number', 'भाग्यांक')), birth.destiny.root),
        ],
      ),
      SectionLabel(s.t(const L('Your grid', 'आपका ग्रिड'))),
      GoldCard(child: _grid(c)),
      Note('${s.t(LoShuMore.usedFrom)}: ${LoShu.dateDigits(dob)}.  ${s.t(LoShuMore.usedAdded)}.'),
      if (heavy)
        Note(s.t(const L(
          'A number that repeats 4 or more times is very strong in you. '
              'Use it wisely and keep the other numbers in balance.',
          'जो अंक 4 या ज़्यादा बार आता है वह आपमें बहुत प्रबल है। उसका समझदारी '
              'से उपयोग करें और बाक़ी अंकों से संतुलन रखें।',
        ))),
      SectionLabel(s.t(const L('Your strong numbers', 'आपके मज़बूत अंक'))),
      for (var n = 1; n <= 9; n++)
        if ((c[n] ?? 0) > 0) InfoRow(Icons.check_circle_outline, '$n', s.t(_have[n]!)),
      SectionLabel(s.t(LoShuMore.linesTitle)),
      Note(s.t(LoShuMore.linesIntro)),
      for (var i = 0; i < LoShu.planes.length; i++)
        InfoRow(
          LoShu.lineCount(c, i) == 3
              ? Icons.auto_awesome
              : (LoShu.lineCount(c, i) == 0
                  ? Icons.radio_button_unchecked
                  : Icons.timelapse),
          '${s.t(_planeNames[i])}  (${LoShu.planes[i].join('-')})',
          '${s.t(L(LoShuMore.stateWordEn[LoShu.lineCount(c, i)], LoShuMore.stateWordHi[LoShu.lineCount(c, i)]))}. '
          '${LoShu.lineCount(c, i) == 3 ? '${s.t(_planeMeanings[i])} ' : ''}'
          '${s.t(LoShuMore.lineState[LoShu.lineCount(c, i)])}',
        ),
      SectionLabel(s.t(LoShuMore.planesTitle)),
      Note(s.t(LoShuMore.planesIntro)),
      for (var g = 0; g < 3; g++)
        InfoRow(
          Icons.layers_outlined,
          s.t(LoShuMore.groupNames[g]),
          '${s.t(LoShuMore.groupMeaning[g])} ${s.t(LoShuMore.groupLevel[LoShu.rowCount(c, g)])}',
        ),
      Note(s.t(LoShu.dominantRow(c) < 0
          ? LoShuMore.balanced
          : LoShuMore.dominant[LoShu.dominantRow(c)])),
      SectionLabel(s.t(LoShuMore.centreTitle)),
      Note(s.t((c[5] ?? 0) > 0 ? LoShuMore.centrePresent : LoShuMore.centreAbsent)),
      if (LoShu.repeated(c).isNotEmpty) ...[
        SectionLabel(s.t(LoShuMore.excessTitle)),
        for (final n in LoShu.repeated(c))
          InfoRow(Icons.repeat, '$n  x${c[n]}', s.t(LoShuMore.excess[n]!)),
      ],
      SectionLabel(s.t(const L('Numbers you can build', 'जिन अंकों को आप बना सकते हैं'))),
      if (missing.isEmpty)
        Note(s.t(const L(
          'All nine numbers are present in your grid.',
          'आपके ग्रिड में नौ के नौ अंक मौजूद हैं।',
        )))
      else ...[
        for (final n in missing)
          InfoRow(Icons.add_circle_outline, '$n', s.t(_lack[n]!)),
        SectionLabel(s.t(LoShuMore.remedyTitle)),
        Note(s.t(LoShuMore.remedyNote)),
        for (final n in missing)
          InfoRow(
            Icons.self_improvement,
            '$n  -  ${s.t(LoShuMore.remedy[n]!.planet)}',
            '${s.t(LoShuMore.dayLabel)}: ${s.t(LoShuMore.remedy[n]!.day)}. '
            '${s.t(LoShuMore.colourLabel)}: ${s.t(LoShuMore.remedy[n]!.colour)}. '
            '${s.t(LoShuMore.habitLabel)}: ${s.t(LoShuMore.remedy[n]!.habit)}',
          ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final dob = _dob;
    return PageShell(
      title: s.t(const L('Lo Shu Grid', 'लो शू ग्रिड')),
      children: [
        Note(s.t(const L(
          'Your birth date digits are placed in a 3x3 grid, together with your '
              'psychic and destiny numbers. It shows which qualities are strong '
              'in you and which ones you can build.',
          'आपकी जन्म तिथि के अंक, मूलांक और भाग्यांक के साथ 3x3 ग्रिड में रखे '
              'जाते हैं। इससे दिखता है कि आपमें कौन-सी बातें मज़बूत हैं और '
              'किन्हें आप बना सकते हैं।',
        ))),
        SectionLabel(s.t(const L('Your date of birth', 'आपकी जन्म तिथि'))),
        DateField(
          label: s.t(const L('Select date of birth', 'जन्म तिथि चुनिए')),
          value: dob,
          onChanged: _save,
        ),
        if (dob != null) ..._result(s, dob),
        Note(s.t(const L(
          'The Lo Shu grid is a traditional tool for reflection. Different '
              'books name the lines slightly differently. A missing number is '
              'not bad luck; it only shows a habit you can build. This is not '
              'a guarantee or advice.',
          'लो शू ग्रिड सोच-विचार का एक पारंपरिक साधन है। अलग-अलग किताबों में '
              'रेखाओं के नाम थोड़े अलग हो सकते हैं। कोई अंक न होना बुरी क़िस्मत '
              'नहीं है; यह सिर्फ़ उस आदत को दिखाता है जो आप बना सकते हैं। यह '
              'गारंटी या सलाह नहीं है।',
        ))),
      ],
    );
  }
}
