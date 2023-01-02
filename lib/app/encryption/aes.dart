import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

class AESAlg {
  static final key = Key.fromUtf8(AppConstants.secret);
  static final iv = IV(convertStringToUint8List('1234567812345678'));
  static final encrypter =
      Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  static String encryption({required String plainText}) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  static String decryption({required String cipherText}) {
    final decrypted = encrypter.decrypt(Encrypted.from64(cipherText), iv: iv);

    return decrypted;
  }

  // ================== SERVICES =================== Don't touch it 😂
  static Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  static String convertUint8ListToString(Uint8List uint8list) {
    return String.fromCharCodes(uint8list);
  }

  // =================

  static String base64ToHex(String source) =>
      base64Decode(LineSplitter.split(source).join())
          .map((e) => e.toRadixString(16).padLeft(2, '0'))
          .join();
}
