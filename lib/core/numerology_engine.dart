import 'knowledge_pack.dart';

/// One letter or digit that contributed to a total.
class BreakdownItem {
  final String symbol;
  final int value;

  const BreakdownItem(this.symbol, this.value);
}

/// Normalized calculation result.
///
/// [total] is always the raw, unclamped total. [root] is the single-digit
/// reduction of [total]. Interpretation text comes from [KnowledgePack] and
/// is only looked up for totals inside the supported compound range.
class NumerologyResult {
  final int total;
  final int root;

  /// The original, unmodified user input.
  final String input;

  /// Every letter/digit that was counted, in order.
  final List<BreakdownItem> items;

  /// Characters that were skipped because they are not supported.
  /// Whitespace is skipped silently and is not listed here.
  final List<String> ignored;

  const NumerologyResult(
    this.total,
    this.root, {
    this.input = '',
    this.items = const [],
    this.ignored = const [],
  });

  /// Example: 32 -> [32, 5]. A single digit gives a one-item list.
  List<int> get reductionChain => NumerologyEngine.reductionChain(total);

  bool get hasCheiroCompound => KnowledgePack.isValidCompound(total);

  String get compoundMeaning => KnowledgePack.compoundMeaning(total);

  CompoundEntry? get compoundEntry => KnowledgePack.compoundEntry(total);
}

/// Birth-date numbers.
///
/// [psychic] is calculated from the day of the month only.
/// [destiny] is calculated from every digit of day, month and year.
class BirthNumbers {
  final NumerologyResult psychic;
  final NumerologyResult destiny;

  const BirthNumbers(this.psychic, this.destiny);
}

class NumerologyEngine {
  /// Chaldean letter values (1-8; the number 9 is not assigned to a letter).
  /// Calculation is kept separate from the interpretation layer.
  static const Map<String, int> letters = {
    'A': 1, 'I': 1, 'J': 1, 'Q': 1, 'Y': 1,
    'B': 2, 'K': 2, 'R': 2,
    'C': 3, 'G': 3, 'L': 3, 'S': 3,
    'D': 4, 'M': 4, 'T': 4,
    'E': 5, 'H': 5, 'N': 5, 'X': 5,
    'U': 6, 'V': 6, 'W': 6,
    'O': 7, 'Z': 7,
    'F': 8, 'P': 8,
  };

  /// Sum of the decimal digits of [n]. Example: 38 -> 11.
  static int digitSum(int n) {
    var x = n.abs();
    var sum = 0;
    while (x > 0) {
      sum += x % 10;
      x ~/= 10;
    }
    return sum;
  }

  /// Reduces [n] to a single digit. 0 stays 0.
  static int root(int n) {
    var x = n.abs();
    while (x > 9) {
      x = digitSum(x);
    }
    return x;
  }

  /// Shows every step of the reduction. Example: 99 -> [99, 18, 9].
  static List<int> reductionChain(int n) {
    var current = n.abs();
    final chain = <int>[current];
    while (current > 9) {
      current = digitSum(current);
      chain.add(current);
    }
    return chain;
  }

  static NumerologyResult _build(
    String input,
    List<BreakdownItem> items,
    List<String> ignored,
  ) {
    final total = items.fold<int>(0, (sum, item) => sum + item.value);
    return NumerologyResult(
      total,
      root(total),
      input: input,
      items: List.unmodifiable(items),
      ignored: List.unmodifiable(ignored),
    );
  }

  static bool _isDigit(String ch) {
    if (ch.length != 1) return false;
    final code = ch.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }

  static int _digitValue(String ch) => ch.codeUnitAt(0) - 48;

  /// Name numerology. Only letters A-Z are counted. Spaces are skipped
  /// silently; digits, punctuation and other alphabets are listed in
  /// [NumerologyResult.ignored].
  static NumerologyResult name(String value) {
    final items = <BreakdownItem>[];
    final ignored = <String>[];
    for (final ch in value.toUpperCase().split('')) {
      final v = letters[ch];
      if (v != null) {
        items.add(BreakdownItem(ch, v));
      } else if (ch.trim().isNotEmpty) {
        ignored.add(ch);
      }
    }
    return _build(value, items, ignored);
  }

  /// Sum of all digits of day, month and year written without padding.
  /// Example: 6 April 1988 -> 6,4,1,9,8,8 -> 36.
  static NumerologyResult date(DateTime date) {
    final raw = '${date.day}${date.month}${date.year}';
    final items = <BreakdownItem>[];
    for (final ch in raw.split('')) {
      items.add(BreakdownItem(ch, _digitValue(ch)));
    }
    return _build(raw, items, const []);
  }

  /// Psychic number (day only) and destiny number (full date).
  static BirthNumbers birth(DateTime date) {
    final dayRaw = '${date.day}';
    final dayItems = <BreakdownItem>[];
    for (final ch in dayRaw.split('')) {
      dayItems.add(BreakdownItem(ch, _digitValue(ch)));
    }
    final psychic = _build(dayRaw, dayItems, const []);
    return BirthNumbers(psychic, NumerologyEngine.date(date));
  }

  /// Mobile number numerology. Every digit the user typed is counted, so a
  /// country code is included only if it was typed. Leading zeros add 0 and
  /// therefore never change the total. Other characters are listed in
  /// [NumerologyResult.ignored].
  static NumerologyResult mobile(String value) {
    final items = <BreakdownItem>[];
    final ignored = <String>[];
    for (final ch in value.split('')) {
      if (_isDigit(ch)) {
        items.add(BreakdownItem(ch, _digitValue(ch)));
      } else if (ch.trim().isNotEmpty) {
        ignored.add(ch);
      }
    }
    return _build(value, items, ignored);
  }

  /// Vehicle registration numerology. Digits count at face value and letters
  /// use the Chaldean values. Spaces are skipped silently; other characters
  /// are listed in [NumerologyResult.ignored].
  static NumerologyResult vehicle(String value) {
    final items = <BreakdownItem>[];
    final ignored = <String>[];
    for (final ch in value.toUpperCase().split('')) {
      if (_isDigit(ch)) {
        items.add(BreakdownItem(ch, _digitValue(ch)));
        continue;
      }
      final v = letters[ch];
      if (v != null) {
        items.add(BreakdownItem(ch, v));
      } else if (ch.trim().isNotEmpty) {
        ignored.add(ch);
      }
    }
    return _build(value, items, ignored);
  }

  static bool isCheiroCompound(int number) {
    return KnowledgePack.isValidCompound(number);
  }
}
