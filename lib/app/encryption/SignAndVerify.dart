import 'dart:convert';
import 'dart:typed_data';

import 'package:crypton/crypton.dart';

import 'aes.dart';

class Rsa{
  static late  RSAKeypair keys;
 static void  init(){
     keys=  RSAKeypair.fromRandom();

  }

  static bool  verify(String msg,sign,RSAPublicKey pub){
     bool verified = pub.verifySHA256Signature(AESAlg.convertStringToUint8List(msg),sign);
     print("Verified: "+verified.toString());
     return verified;
   }
   static Uint8List  sign(String msg,RSAPrivateKey priv){
     final Uint8List  signature = keys.privateKey.createSHA256Signature(utf8.encode(msg) as Uint8List);


     print("SIGN: "+base64.encode(signature));
     return signature;
   }

}