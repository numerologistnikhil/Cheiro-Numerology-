import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One saved client. Everything is stored encrypted.
class ClientRecord {
  final String id;
  final String name;
  final DateTime? dob;
  final String notes;

  const ClientRecord({
    required this.id,
    required this.name,
    this.dob,
    this.notes = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dob': dob?.toIso8601String(),
        'notes': notes,
      };

  factory ClientRecord.fromJson(Map<String, dynamic> j) => ClientRecord(
        id: j['id'] as String,
        name: j['name'] as String,
        dob: j['dob'] == null ? null : DateTime.parse(j['dob'] as String),
        notes: (j['notes'] as String?) ?? '',
      );
}

/// Local encrypted storage.
///
/// Records are encrypted with AES-256-GCM using a random key that is created
/// on first use and kept in the Android secure storage. A fresh random IV is
/// used for every save. Nothing leaves the phone. If the app data is cleared
/// or the app is uninstalled, the key and the records are lost.
class LocalVault {
  static const _keyName = 'ankdhara_vault_key_v2';
  static const _dataName = 'ankdhara_clients_v1';

  final FlutterSecureStorage storage;
  const LocalVault({this.storage = const FlutterSecureStorage()});

  Future<List<int>> _keyBytes() async {
    var k = await storage.read(key: _keyName);
    if (k == null) {
      final r = Random.secure();
      final bytes = List<int>.generate(32, (_) => r.nextInt(256));
      k = base64UrlEncode(bytes);
      await storage.write(key: _keyName, value: k);
    }
    return base64Url.decode(k);
  }

  Future<String> encryptText(String plain) async {
    final key = enc.Key.fromBase64(base64.encode(await _keyBytes()));
    final iv = enc.IV.fromSecureRandom(12);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.gcm));
    final out = encrypter.encrypt(plain, iv: iv);
    return '${iv.base64}.${out.base64}';
  }

  Future<String> decryptText(String packed) async {
    final parts = packed.split('.');
    if (parts.length != 2) {
      throw const FormatException('Unrecognised vault data');
    }
    final key = enc.Key.fromBase64(base64.encode(await _keyBytes()));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.gcm));
    return encrypter.decrypt64(parts[1], iv: enc.IV.fromBase64(parts[0]));
  }

  Future<List<ClientRecord>> loadClients() async {
    final prefs = await SharedPreferences.getInstance();
    final packed = prefs.getString(_dataName);
    if (packed == null || packed.isEmpty) return [];
    final json = jsonDecode(await decryptText(packed)) as List<dynamic>;
    return json
        .map((e) => ClientRecord.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveClients(List<ClientRecord> list) async {
    final prefs = await SharedPreferences.getInstance();
    final text = jsonEncode(list.map((c) => c.toJson()).toList());
    await prefs.setString(_dataName, await encryptText(text));
  }

  /// Keyed hash of some data (kept from Batch 1).
  Future<String> fingerprint(String data) async {
    final k = await _keyBytes();
    return Hmac(sha256, k).convert(utf8.encode(data)).toString();
  }
}
