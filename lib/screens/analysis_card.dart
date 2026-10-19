import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/knowledge_pack.dart';
import '../core/numerology_engine.dart';

class AnalysisCard extends StatelessWidget {
  final String title;
  final NumerologyResult? result;

  const AnalysisCard({super.key, required this.title, required this.result});

  String clean(String s) {
    var t = s.replaceFirst('Modern guidance: ', '');
    t = t.replaceFirst('Traditionally linked with ', 'Linked with ');
    if (t.isEmpty) return t;
    return t[0].toUpperCase() + t.substring(1);
  }

  Widget section(IconData icon, String heading, String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AnkdharaColors.cream,
            ),
            child: Icon(icon, size: 19, color: AnkdharaColors.gold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: AnkdharaColors.gold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(body, style: const TextStyle(fontSize: 14.5, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = result;
    if (r == null) return const SizedBox.shrink();

    final entry = r.hasCheiroCompound ? KnowledgePack.compoundEntry(r.total) : null;

    final body = <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AnkdharaColors.gold, AnkdharaColors.goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44B8860B),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              '${r.root}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Compound ${r.total}  •  Root ${r.root}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AnkdharaColors.gold,
                  ),
                ),
                if (entry != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    entry.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Container(height: 1, color: AnkdharaColors.goldLine),
    ];

    if (entry != null) {
      body.add(section(Icons.auto_stories_outlined, 'Overview', clean(entry.summary)));
      body.add(section(Icons.bolt, 'Strengths', entry.strengths));
      body.add(section(Icons.warning_amber_rounded, 'Cautions', entry.cautions));
      body.add(section(Icons.favorite_border, 'Relationships', entry.relationships));
      body.add(section(Icons.work_outline, 'Work and Career', entry.work));
      body.add(section(Icons.account_balance_wallet_outlined, 'Money', entry.money));
      body.add(section(Icons.lightbulb_outline, 'Advice', entry.advice));
    } else {
      body.add(section(Icons.auto_stories_outlined, 'Overview', clean(r.compoundMeaning)));
    }

    body.add(section(
      Icons.auto_awesome,
      'Root Number ${r.root}',
      KnowledgePack.rootMeaning(r.root),
    ));

    if (entry != null) {
      body.add(const SizedBox(height: 16));
      body.add(Text(
        entry.statusLabel,
        style: const TextStyle(fontSize: 11.5, color: Color(0xFF8A7F6A)),
      ));
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, 24 * (1 - v)), child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: body,
            ),
          ),
        ),
      ),
    );
  }
}
