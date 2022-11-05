// service for store/ restore/ check value existence
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> store(key, value) async{
    bool exist = await isKeyExist(key);
    if(exist) {
      throw Exception("Key already exist");
    } else {
      await _storage.write(key: key, value: value);
    }
  }

  static Future<bool> isKeyExist(key) async{
    Map<String, String> allValues = await _storage.readAll();
    return allValues.containsKey(key);
  }

  static Future<String?> get(key) async{
      String? value = await _storage.read(key: key);
      return value;
  }
}
