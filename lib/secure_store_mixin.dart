import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin SecureStoreMixin {
  final secureStore = new FlutterSecureStorage();

  void setSecureStore (String key, String data) async {
    await secureStore.write(key: key, value: data);
  }

  Future<String> getSecureStore (String key) async {
    return await secureStore.read(key: key);
  }

  void clearAll () async {
    await secureStore.deleteAll();
  }
}