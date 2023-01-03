// import 'package:crypton/crypton.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import 'package:m3g_chat/app/socket_io/socket_io.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'app/encryption/pgp_algorithm.dart';
import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SocketIO.initSocket();

  // final publicPem = await rootBundle.loadString('assets/public.pem');
  // final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
  //
  // final privatePem = await rootBundle.loadString('assets/private.pem');
  // final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;
  //
  // const plainText = 'random';
  // final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  //
  // final encrypted = encrypter.encrypt(plainText);
  // final decrypted = encrypter.decrypt(encrypted);

  // print(decrypted);
  // print(encrypted.base64);
  // print('Private Key : ${privKey.toString()}');
  // print('Pub Key : ${publicKey.toString()}');




  print(AppConstants.sessionKey);
  AppConstants.sessionKey = await PGPAlGO.encryptSession();
  print(AppConstants.sessionKey);


  runApp(MyApp());
}
