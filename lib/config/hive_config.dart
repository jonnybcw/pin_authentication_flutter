import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

const String pinBoxId = 'pinBox';

const String userPin = 'userPin';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<Box<String>?> getUserPinBox() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? key = await secureStorage.read(key: 'encryptionKey');
    if (key == null) {
      return null;
    }
    List<int> encryptionKey = base64Url.decode(key);
    return await Hive.openBox(
      pinBoxId,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  static Future<String?> getUserPin() async {
    Box<String>? box = await getUserPinBox();
    return box?.get(userPin);
  }

  static Future<void> saveUserPin(String newPin) async {
    Box<String>? box = await getUserPinBox();
    await box?.put(userPin, newPin);
  }
}
