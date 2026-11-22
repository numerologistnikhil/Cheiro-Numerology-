/// Turns what a person SAID ("my name is Rahul Sharma, born 15 August 1990,
/// mobile 98765 43210") into name, date of birth and mobile number.
///
/// Pure Dart, no plugins, so it can be tested without a phone. The words come
/// from the phone's speech recogniser; this file only finds the details in
/// them. The screen always shows the result for the person to confirm.
class VoiceDetails {
  final String name;
  final DateTime? dob;
  final String mobile;
  const VoiceDetails({this.name = '', this.dob, this.mobile = ''});

  bool get isEmpty => name.isEmpty && dob == null && mobile.isEmpty;
}

class VoiceParser {
  VoiceParser._();

  static const Map<String, int> _months = {
    'january': 1, 'jan': 1, 'janwari': 1, 'जनवरी': 1,
    'february': 2, 'feb': 2, 'farwari': 2, 'pharwari': 2, 'फरवरी': 2, 'फ़रवरी': 2,
    'march': 3, 'mar': 3, 'maarch': 3, 'मार्च': 3,
    'april': 4, 'apr': 4, 'aprail': 4, 'अप्रैल': 4,
    'may': 5, 'mai': 5, 'मई': 5,
    'june': 6, 'jun': 6, 'joon': 6, 'जून': 6,
    'july': 7, 'jul': 7, 'julai': 7, 'जुलाई': 7,
    'august': 8, 'aug': 8, 'agast': 8, 'agust': 8, 'अगस्त': 8,
    'september': 9, 'sep': 9, 'sept': 9, 'sitambar': 9, 'सितंबर': 9, 'सितम्बर': 9,
    'october': 10, 'oct': 10, 'aktoobar': 10, 'october.': 10, 'अक्टूबर': 10, 'अक्तूबर': 10,
    'november': 11, 'nov': 11, 'navambar': 11, 'नवंबर': 11, 'नवम्बर': 11,
    'december': 12, 'dec': 12, 'disambar': 12, 'दिसंबर': 12, 'दिसम्बर': 12,
  };

  static const Set<String> _stop = {
    'born', 'dob', 'date', 'birth', 'birthday', 'janm', 'janam', 'janmatithi',
    'mobile', 'phone', 'number', 'contact', 'my', 'mera', 'meri', 'and', 'aur',
    'on', 'was', 'hai', 'hain', 'he', 'h', 'is', 'am', 'tarikh', 'tithi',
    'जन्म', 'जन्मतिथि', 'तारीख', 'मोबाइल', 'फोन', 'फ़ोन', 'नंबर', 'नम्बर',
    'और', 'है', 'हैं', 'मेरा', 'मेरी', 'को', 'में', 'पर', 'हुआ', 'हुई',
    'dated', 'year', 'saal', 'साल', 'महीना', 'month',
  };

  static final RegExp _nameMarker = RegExp(
    r'(?<![a-z\u0900-\u097F])(?:my full name is|my name is|name is|this is|i am|im|mera poora naam|mera pura naam|mera naam|mera nam|my naam|naam|nam|मेरा पूरा नाम|मेरा नाम|नाम)\s*(?:है|hai|is)?\s+',
  );

  static String _digits(String s) {
    const dev = '०१२३४५६७८९';
    final b = StringBuffer();
    for (final r in s.runes) {
      final c = String.fromCharCode(r);
      final i = dev.indexOf(c);
      b.write(i >= 0 ? '$i' : c);
    }
    return b.toString();
  }

  static const Map<String, int> _numWords = {
    'zero': 0, 'oh': 0, 'o': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
    'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9,
    'ek': 1, 'do': 2, 'teen': 3, 'char': 4, 'chaar': 4, 'paanch': 5,
    'panch': 5, 'chhe': 6, 'chhah': 6, 'saat': 7, 'aath': 8, 'nau': 9,
    'shunya': 0, 'sifar': 0,
  };

  /// "nine eight seven" -> "987"; only when the word is a single digit.
  static String _spokenDigits(String s) {
    final words = s.split(RegExp(r'\s+'));
    final out = <String>[];
    for (final w in words) {
      final v = _numWords[w];
      out.add(v != null ? '$v' : w);
    }
    return out.join(' ');
  }

  static String _clean(String raw) {
    var s = _digits(raw.toLowerCase());
    s = s.replaceAll(RegExp(r'[,;|]'), ' ');
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }

  /// Finds a 10-digit Indian mobile number. Spaces and hyphens are allowed.
  static String _findMobile(String s) {
    final spoken = _spokenDigits(s);
    for (final text in [s, spoken]) {
      final m = RegExp(r'(?:\+?\s?91[\s-]*)?([6-9](?:[\s-]?\d){9})(?!\d)')
          .allMatches(text);
      for (final x in m) {
        final d = x.group(1)!.replaceAll(RegExp(r'\D'), '');
        if (d.length == 10) {
          // A date such as "8 8 1990" must not be taken as a mobile number.
          final lead = text.substring(0, x.start);
          final isDate = RegExp(r'(?:\d{1,2}[\s/.-]){2}$').hasMatch(lead) ||
              RegExp(r'^\d{1,2}[\s/.-]\d{1,2}[\s/.-]\d{4}$')
                  .hasMatch(x.group(0)!.trim());
          if (!isDate) return d;
        }
      }
    }
    return '';
  }

  static DateTime? _valid(int d, int m, int y) {
    if (y < 1900 || y > DateTime.now().year) return null;
    if (m < 1 || m > 12 || d < 1 || d > 31) return null;
    final dt = DateTime(y, m, d);
    if (dt.month != m || dt.day != d) return null;
    if (dt.isAfter(DateTime.now())) return null;
    return dt;
  }

  static DateTime? _findDob(String s) {
    final text = s.replaceAllMapped(RegExp(r'(\d)(st|nd|rd|th)\b'), (m) => m.group(1)!);
    final names = _months.keys.where((k) => !k.endsWith('.')).toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    final mon = names.map(RegExp.escape).join('|');

    // 15 August 1990
    final a = RegExp('(\\d{1,2})\\s*(?:tarikh|तारीख)?\\s*(?:of\\s+)?($mon)\\s*(?:ko)?\\s*(\\d{4})')
        .firstMatch(text);
    if (a != null) {
      final r = _valid(int.parse(a.group(1)!), _months[a.group(2)]!, int.parse(a.group(3)!));
      if (r != null) return r;
    }
    // August 15 1990
    final b = RegExp('($mon)\\s+(\\d{1,2})\\s+(\\d{4})').firstMatch(text);
    if (b != null) {
      final r = _valid(int.parse(b.group(2)!), _months[b.group(1)]!, int.parse(b.group(3)!));
      if (r != null) return r;
    }
    // 15/08/1990, 15-8-1990, 15.08.1990, 15 8 1990 (day first, as in India)
    final c = RegExp(r'(?<!\d)(\d{1,2})[\s/.-]+(\d{1,2})[\s/.-]+(\d{4})(?!\d)')
        .firstMatch(text);
    if (c != null) {
      final r = _valid(int.parse(c.group(1)!), int.parse(c.group(2)!), int.parse(c.group(3)!));
      if (r != null) return r;
    }
    // 15081990 as one block of 8 digits
    final e = RegExp(r'(?<!\d)(\d{2})(\d{2})(\d{4})(?!\d)').firstMatch(text);
    if (e != null) {
      final r = _valid(int.parse(e.group(1)!), int.parse(e.group(2)!), int.parse(e.group(3)!));
      if (r != null) return r;
    }
    return null;
  }

  static bool _isStopOrDate(String w) {
    if (_stop.contains(w)) return true;
    if (_months.containsKey(w)) return true;
    if (RegExp(r'\d').hasMatch(w)) return true;
    return false;
  }

  static String _findName(String s) {
    final m = _nameMarker.firstMatch('$s ');
    var rest = '';
    if (m != null) {
      rest = s.substring(m.end > s.length ? s.length : m.end);
    } else {
      rest = s; // a bare "Rahul Sharma 15 august 1990"
    }
    final out = <String>[];
    for (final w in rest.split(' ')) {
      if (w.isEmpty) continue;
      if (_isStopOrDate(w)) {
        if (out.isEmpty && m == null) continue;
        break;
      }
      out.add(w);
      if (out.length >= 5) break;
    }
    while (out.isNotEmpty && _stop.contains(out.last)) {
      out.removeLast();
    }
    final joined = out.join(' ');
    if (joined.isEmpty) return '';
    final hasDev = RegExp(r'[ऀ-ॿ]').hasMatch(joined);
    final latin = hasDev ? transliterate(joined) : joined;
    return latin
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  static VoiceDetails parse(String raw) {
    final s = _clean(raw);
    if (s.isEmpty) return const VoiceDetails();
    final mobile = _findMobile(s);
    var rest = s;
    if (mobile.isNotEmpty) {
      // Remove the mobile number words so that they do not become a name.
      rest = rest.replaceAll(RegExp(r'(?:\+?\s?91[\s-]*)?[6-9](?:[\s-]?\d){9}(?!\d)'), ' ');
    }
    final dob = _findDob(rest);
    final tidy = rest.replaceAll(RegExp(r'\s+'), ' ').trim();
    var name = _findName(tidy);
    final marked = _nameMarker.hasMatch('$tidy ');
    if (!marked && dob == null && mobile.isEmpty && name.split(' ').length > 3) {
      name = '';
    }
    return VoiceDetails(
      name: name,
      dob: dob,
      mobile: mobile,
    );
  }

  // ---- Devanagari to Latin (names only, simple and readable) -------------

  static const Map<String, String> _vowels = {
    'अ': 'a', 'आ': 'aa', 'इ': 'i', 'ई': 'ee', 'उ': 'u', 'ऊ': 'oo',
    'ए': 'e', 'ऐ': 'ai', 'ओ': 'o', 'औ': 'au', 'ऋ': 'ri',
  };
  static const Map<String, String> _matras = {
    'ा': 'a', 'ि': 'i', 'ी': 'ee', 'ु': 'u', 'ू': 'oo', 'े': 'e',
    'ै': 'ai', 'ो': 'o', 'ौ': 'au', 'ृ': 'ri', 'ॉ': 'o',
  };
  static const Map<String, String> _cons = {
    'क': 'k', 'ख': 'kh', 'ग': 'g', 'घ': 'gh', 'ङ': 'n',
    'च': 'ch', 'छ': 'chh', 'ज': 'j', 'झ': 'jh', 'ञ': 'n',
    'ट': 't', 'ठ': 'th', 'ड': 'd', 'ढ': 'dh', 'ण': 'n',
    'त': 't', 'थ': 'th', 'द': 'd', 'ध': 'dh', 'न': 'n',
    'प': 'p', 'फ': 'f', 'ब': 'b', 'भ': 'bh', 'म': 'm',
    'य': 'y', 'र': 'r', 'ल': 'l', 'व': 'v', 'श': 'sh', 'ष': 'sh',
    'स': 's', 'ह': 'h', 'ळ': 'l', 'ज़': 'z', 'फ़': 'f', 'क़': 'q',
    'ड़': 'r', 'ढ़': 'rh',
  };

  static String transliterate(String input) {
    final chars = input.replaceAll('़', '').split('');
    final b = StringBuffer();
    for (var i = 0; i < chars.length; i++) {
      final c = chars[i];
      final next = i + 1 < chars.length ? chars[i + 1] : '';
      if (_cons.containsKey(c)) {
        b.write(_cons[c]);
        if (_matras.containsKey(next)) {
          // the matra is written on its own turn
        } else if (next == '्') {
          i++; // halant: no vowel
        } else if (next == '' || next == ' ') {
          // word end: no trailing "a" (Rahul, not Rahula)
        } else {
          b.write('a');
        }
      } else if (_matras.containsKey(c)) {
        b.write(_matras[c]);
      } else if (_vowels.containsKey(c)) {
        b.write(_vowels[c]);
      } else if (c == 'ं' || c == 'ँ') {
        b.write('n');
      } else if (c == 'ः') {
        b.write('h');
      } else if (c == ' ') {
        b.write(' ');
      } else if (RegExp(r'[a-z0-9]').hasMatch(c)) {
        b.write(c);
      }
    }
    return b.toString();
  }
}
