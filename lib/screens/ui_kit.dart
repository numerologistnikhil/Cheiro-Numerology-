import 'profile_screen.dart';
import '../core/user_profile.dart';
import 'package:flutter/material.dart';
import '../core/app.dart';

const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

String monthName(int month) => _months[month - 1];

/// Standard page: pearl background, scrolling list, safe padding.
class PageShell extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const PageShell({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 6, 14, 24),
          children: children,
        ),
      ),
    );
  }
}

/// Fades and slides its child in once.
class FadeIn extends StatelessWidget {
  final Widget child;
  const FadeIn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      builder: (context, v, c) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, 20 * (1 - v)), child: c),
      ),
      child: child,
    );
  }
}

class GoldCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const GoldCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: padding, child: child));
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12.5,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w800,
          color: AnkdharaColors.gold,
        ),
      ),
    );
  }
}

/// Small disclaimer box.
class Note extends StatelessWidget {
  final String text;
  const Note(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AnkdharaColors.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AnkdharaColors.goldLine),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.5, height: 1.5),
      ),
    );
  }
}

class NumberBadge extends StatelessWidget {
  final int number;
  final double size;
  const NumberBadge(this.number, {super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        '$number',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.48,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class DateField extends StatefulWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// When true and nothing is chosen yet, the saved profile date of birth is
  /// filled in automatically. Use false for another person's date.
  final bool usesProfile;

  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.usesProfile = true,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  bool get _fromProfile =>
      widget.usesProfile && UserProfile.instance.dob != null;

  void _sync() {
    if (!mounted) return;
    final d = UserProfile.instance.dob;
    if (widget.usesProfile && d != null && widget.value != d) {
      final first = widget.firstDate ?? DateTime(1900);
      final last = widget.lastDate ?? DateTime.now();
      if (!d.isBefore(first) && !d.isAfter(last)) widget.onChanged(d);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.usesProfile) {
      UserProfile.instance.addListener(_sync);
      UserProfile.instance.ensureLoaded().then((_) => _sync());
    }
  }

  @override
  void dispose() {
    if (widget.usesProfile) UserProfile.instance.removeListener(_sync);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fromProfile) {
      return const ProfileStrip(margin: EdgeInsets.zero);
    }
    final value = widget.value;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime.now(),
          initialDate: value ?? DateTime(1990),
        );
        if (picked != null) widget.onChanged(picked);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AnkdharaColors.goldLine),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: AnkdharaColors.gold),
            const SizedBox(width: 12),
            Text(
              value == null ? widget.label : formatDate(value),
              style: TextStyle(
                fontSize: 16,
                color: value == null ? const Color(0xFF8A7F6A) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String body;
  const InfoRow(this.icon, this.heading, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AnkdharaColors.cream,
              border: Border.all(color: AnkdharaColors.goldLine),
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
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(fontSize: 14.5, height: 1.55)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Pill extends StatelessWidget {
  final String text;
  final Color color;
  const Pill(this.text, {super.key, this.color = AnkdharaColors.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Row of 1-9 chips.
class NumberChips extends StatelessWidget {
  final int? selected;
  final ValueChanged<int> onSelected;
  const NumberChips({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var n = 1; n <= 9; n++)
          ChoiceChip(
            label: Text('$n'),
            selected: selected == n,
            selectedColor: AnkdharaColors.goldLight,
            onSelected: (_) => onSelected(n),
          ),
      ],
    );
  }
}
