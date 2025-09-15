import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final _storage = const FlutterSecureStorage();
  static const _kAccess = 'access_token';

  Future<void> saveAccessToken(String token) => _storage.write(key: _kAccess, value: token);
  Future<String?> readAccessToken() => _storage.read(key: _kAccess);

  Future<void> clearAll() async {
    await _storage.delete(key: _kAccess);
  }
}
