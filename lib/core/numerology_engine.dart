import 'knowledge_pack.dart';

class NumerologyResult {
  final int total;
  final int root;

  const NumerologyResult(this.total, this.root);

  bool get hasCheiroCompound =>
      KnowledgePack.isValidCompound(total);

  String get compoundMeaning =>
      KnowledgePack.compoundMeaning(total);
}

class NumerologyEngine {
  // Chaldean-style letter values.
  // Calculation is separate from the Cheiro interpretation layer.
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

  static int root(int n) {
    n = n.abs();
    while (n > 9) {
      n = n
          .toString()
          .split('')
          .map(int.parse)
          .reduce((a, b) => a + b);
    }
    return n;
  }

  static NumerologyResult name(String value) {
    final cleaned =
        value.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    final total = cleaned.split('').fold<int>(
      0,
      (sum, char) => sum + (letters[char] ?? 0),
    );
    return NumerologyResult(total, root(total));
  }

  static NumerologyResult date(DateTime date) {
    final raw = '${date.day}${date.month}${date.year}';
    final total = raw
        .split('')
        .map(int.parse)
        .fold<int>(0, (sum, digit) => sum + digit);
    return NumerologyResult(total, root(total));
  }

  static NumerologyResult mobile(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final total = digits.split('').fold<int>(
      0,
      (sum, digit) => sum + int.parse(digit),
    );
    return NumerologyResult(total, root(total));
  }

  static NumerologyResult vehicle(String value) {
    final mapped = value.toUpperCase().split('').fold<int>(
      0,
      (sum, char) => sum + (int.tryParse(char) ?? letters[char] ?? 0),
    );
    return NumerologyResult(mapped, root(mapped));
  }

  static bool isCheiroCompound(int number) {
    return KnowledgePack.isValidCompound(number);
  }
}
