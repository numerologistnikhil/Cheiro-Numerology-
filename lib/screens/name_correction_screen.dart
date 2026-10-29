import 'package:flutter/material.dart';

import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/name_suggester.dart';
import '../core/name_texts.dart';
import '../core/numerology_engine.dart';
import '../core/user_profile.dart';
import 'profile_screen.dart';
import 'ui_kit.dart';

/// Name Correction: the app looks at the name and the date of birth, suggests
/// 5 to 10 better spellings, explains each one, and lets the customer choose.
class NameCorrectionScreen extends StatefulWidget {
  const NameCorrectionScreen({super.key});

  @override
  State<NameCorrectionScreen> createState() => _NameCorrectionScreenState();
}

class _NameCorrectionScreenState extends State<NameCorrectionScreen> {
  final TextEditingController _name = ProfileController.name();
  final TextEditingController _alt = TextEditingController();
  DateTime? _dob;
  NameSuggestions? _result;
  bool _noLatin = false;

  NumerologyResult? _cmpA;
  NumerologyResult? _cmpB;
  bool _cmpError = false;

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
    _alt.dispose();
    super.dispose();
  }

  void _suggest() {
    FocusScope.of(context).unfocus();
    final r = NameSuggester.suggest(_name.text, dob: _dob);
    setState(() {
      _result = r;
      _noLatin = r == null;
    });
  }

  Future<void> _choose(NameSuggestion s) async {
    await UserProfile.instance.setChosenName(s.name);
    if (mounted) setState(() {});
  }

  Future<void> _unchoose() async {
    await UserProfile.instance.setChosenName('');
    if (mounted) setState(() {});
  }

  void _compare() {
    FocusScope.of(context).unfocus();
    final a = NumerologyEngine.name(_name.text.trim());
    final b = NumerologyEngine.name(_alt.text.trim());
    setState(() {
      if (a.total == 0 || b.total == 0) {
        _cmpError = true;
        _cmpA = null;
        _cmpB = null;
      } else {
        _cmpError = false;
        _cmpA = a;
        _cmpB = b;
      }
    });
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AnkdharaColors.gold,
          ),
        ),
      );

  Widget _field(String label, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: AnkdharaColors.gold,
              ),
            ),
            const SizedBox(height: 2),
            Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      );

  Widget _currentCard(NameSuggestions r, bool hi) {
    final sc = r.originalScore;
    return GoldCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            NameTexts.current.t(hi),
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: AnkdharaColors.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(r.original,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(
            hi
                ? 'जोड़ ${r.originalTotal}, मूल अंक ${r.originalRoot}. नाम का संकेत: ${sc.label.of(true)} (धन ${sc.wealth}/100, भाग्य ${sc.luck}/100)'
                : 'Total ${r.originalTotal}, root ${r.originalRoot}. Name guide: ${sc.label.of(false)} (money ${sc.wealth}/100, luck ${sc.luck}/100)',
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _tile(NameSuggestions all, int index, NameSuggestion s, bool hi) {
    final chosen =
        UserProfile.instance.chosenName.toLowerCase() == s.name.toLowerCase();
    final tag = s.better ? NameTexts.better.t(hi) : NameTexts.similar.t(hi);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          '${index + 1}.  ${s.name}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          '${s.total} → ${s.root}   ·   $tag${chosen ? '   ·   ✓' : ''}',
          style: TextStyle(
            fontSize: 12.5,
            color: s.better ? AnkdharaColors.gold : const Color(0xFF6F6650),
            fontWeight: FontWeight.w700,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              NameSuggester.explain(all, s, hi),
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          for (final row in NameSuggester.details(s, hi))
            _field(row.key, row.value),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: chosen
                ? OutlinedButton.icon(
                    onPressed: _unchoose,
                    icon: const Icon(Icons.check_circle),
                    label: Text(
                        '${NameTexts.chosenButton.t(hi)} · ${NameTexts.clearChoice.t(hi)}'),
                  )
                : FilledButton(
                    onPressed: () => _choose(s),
                    child: Text(NameTexts.chooseButton.t(hi)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _compareResult(bool hi) {
    final a = _cmpA;
    final b = _cmpB;
    if (_cmpError) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(NameTexts.noLatin.t(hi),
            style: const TextStyle(color: Colors.red)),
      );
    }
    if (a == null || b == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_name.text.trim()}:  ${hi ? 'जोड़' : 'total'} ${a.total} → ${a.root}',
              style: const TextStyle(fontSize: 14.5, height: 1.5),
            ),
            Text(
              '${_alt.text.trim()}:  ${hi ? 'जोड़' : 'total'} ${b.total} → ${b.root}',
              style: const TextStyle(
                  fontSize: 14.5, height: 1.5, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    final r = _result;
    final chosen = UserProfile.instance.chosenName;
    return PageShell(
      title: hi ? 'नाम सुधार' : 'Name Correction',
      children: [
        Note(hi
            ? 'ऐप आपका नाम और जन्म तिथि देखकर 10 तक बेहतर वर्तनी खुद सुझाती है। हर सुझाव को विस्तार से पढ़िए, फिर अपना नया नाम चुनिए।'
            : 'The app looks at your name and date of birth and suggests up to 10 better spellings on its own. Read each one in detail, then choose your new name.'),
        const SizedBox(height: 12),
        const ProfileStrip(margin: EdgeInsets.only(bottom: 10)),
        ProfileHide(
          child: TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: NameTexts.nameLabel.t(hi),
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
        ),
        const SizedBox(height: 10),
        DateField(
          label: hi ? 'जन्म तिथि' : 'Date of birth',
          value: _dob,
          onChanged: (d) => setState(() => _dob = d),
        ),
        if (_dob == null && UserProfile.instance.dob == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(NameTexts.needDob.t(hi),
                style: const TextStyle(fontSize: 12.5, height: 1.4)),
          ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _suggest,
            icon: const Icon(Icons.auto_awesome),
            label: Text(NameTexts.suggestButton.t(hi)),
          ),
        ),
        if (chosen.isNotEmpty) ...[
          const SizedBox(height: 10),
          GoldCard(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: AnkdharaColors.gold),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${NameTexts.chosenTitle.t(hi)}:  $chosen',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (_noLatin)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(NameTexts.noLatin.t(hi),
                style: const TextStyle(color: Colors.red)),
          ),
        if (r != null) ...[
          const SizedBox(height: 12),
          _currentCard(r, hi),
          if (!r.anyBetter)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(NameTexts.noneBetter.t(hi),
                  style: const TextStyle(fontSize: 13.5, height: 1.45)),
            ),
          _label(NameTexts.title.t(hi)),
          for (var i = 0; i < r.items.length; i++) _tile(r, i, r.items[i], hi),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 4),
            child: Text(NameTexts.chooseTitle.t(hi),
                style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          Text(NameTexts.chooseBody.t(hi),
              style: const TextStyle(fontSize: 13.5, height: 1.45)),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Text(NameTexts.cautionTitle.t(hi),
                style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          Text(NameTexts.cautionBody.t(hi),
              style: const TextStyle(fontSize: 13.5, height: 1.45)),
        ],
        _label(NameTexts.compareTitle.t(hi)),
        TextField(
          controller: _alt,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: NameTexts.altLabel.t(hi),
            prefixIcon: const Icon(Icons.edit_outlined),
          ),
          onSubmitted: (_) => _compare(),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _compare,
            child: Text(NameTexts.compareButton.t(hi)),
          ),
        ),
        _compareResult(hi),
        const SizedBox(height: 14),
        Text(NameTexts.method.t(hi), style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
