import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'report_options.dart';

/// Saves the customer's PDF choices on this phone only.
class ReportOptionsStore {
  ReportOptionsStore._();

  static const String _key = 'report_options_v1';

  static Future<ReportOptions> load() async {
    try {
      final p = await SharedPreferences.getInstance();
      final s = p.getString(_key);
      if (s == null || s.isEmpty) return const ReportOptions();
      return ReportOptions.fromJson(jsonDecode(s) as Map<String, dynamic>);
    } catch (_) {
      return const ReportOptions();
    }
  }

  static Future<void> save(ReportOptions o) async {
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_key, jsonEncode(o.toJson()));
    } catch (_) {
      // Saving is best effort; the report still works.
    }
  }
}
