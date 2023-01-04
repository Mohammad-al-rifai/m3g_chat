import 'package:flutter/material.dart';
import 'package:m3g_chat/app/socket_io/socket_io.dart';

import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SocketIO.initSocket();
  runApp(MyApp());

/*
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

/*
  print(AppConstants.sessionKey);
  AppConstants.sessionKey = await PGPAlGO.encryptSession();
  //print(AppConstants.sessionKey);


 final RSAKeypair keys=  RSAKeypair.fromRandom();
  print("publicKey");
 print(keys.publicKey);
 print("privateKEY : ");
 print(keys.privateKey);

   final publicKey = keys.publicKey.toPEM() as RSAPublicKey ;
   final privateKey =keys.privateKey.toPEM() as RSAPrivateKey ;

  final Uint8List  signature = privateKey.createSHA256Signature(utf8.encode("message") as Uint8List);
  print("sing");

  print(base64.encode(signature));
  bool verified = publicKey.verifySHA256Signature(AESAlg.convertStringToUint8List("message"),signature);
  print(verified);
  //final signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: publicKey, privateKey: keys.privateKey));

  // print(signer.sign('hello world').base64);
  // print(signer.verify64('hello world', 'jfMhNM2v6hauQr6w3ji0xNOxGInHbeIH3DHlpf2W3vmSMyAuwGHG0KLcunggG4XtZrZPAib7oHaKEAdkHaSIGXAtEqaAvocq138oJ7BEznA4KVYuMcW9c8bRy5E4tUpikTpoO+okHdHr5YLc9y908CAQBVsfhbt0W9NClvDWegs='));
*/



  // final algorithm = RsaSsaPkcs1v15(
  //   Sha256(),
  // );
  //
  // // Generate a key pair
  // final keyPair = await algorithm.newKeyPair();
  //
  // // Sign a message
  // final message = <int>[1, 2, 3];
  // final signature = await algorithm.sign(
  //   message,
  //   keyPair: keyPair,
  // );
  // print('Signature bytes: ${signature.bytes}');
  // print('Public key: ${signature.publicKey}');
  //
  // // Anyone can verify the signature
  // final isSignatureCorrect = await algorithm.verify(
  //   message,
  //   signature: signature,
  // );
*/
}
