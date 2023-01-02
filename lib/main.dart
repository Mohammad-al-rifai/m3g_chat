import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import 'package:m3g_chat/app/socket_io/socket_io.dart';

import 'app/encryption/aes.dart';
import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SocketIO.initSocket();

  print('AllHammdllah');
  print(AESAlg.base64ToHex(AESAlg.encryption(plainText: 'hello')));
  print(AESAlg.decryption(cipherText: base64.encode(decodeHexString('7030797C09E38F4B63BDA86CE7EBA0F7'))));

  runApp(MyApp());

  // 7030797C09E38F4B63BDA86CE7EBA0F7
}
