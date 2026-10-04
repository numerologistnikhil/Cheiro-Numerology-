import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalVault {
  static const _keyName='cheiro_vault_key';
  final FlutterSecureStorage storage;
  const LocalVault({this.storage=const FlutterSecureStorage()});
  Future<String> _key() async {
    var k=await storage.read(key:_keyName);
    if(k==null){ k=base64UrlEncode(List<int>.generate(32,(i)=>DateTime.now().microsecondsSinceEpoch.hashCode+i)); await storage.write(key:_keyName,value:k); }
    return k;
  }
  Future<String> fingerprint(String data) async { final k=await _key(); return Hmac(sha256,utf8.encode(k)).convert(utf8.encode(data)).toString(); }
}
