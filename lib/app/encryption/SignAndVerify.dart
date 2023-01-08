// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto_keys/crypto_keys.dart';
import 'package:crypton/crypton.dart';

import 'aes.dart';

class Rsa {
  static late RSAKeypair keys;
  static var keyPair;

  static void init() {
    keys = RSAKeypair.fromRandom();
    keyPair = KeyPair.fromJwk({
      "kty": "oct",
      "k": "AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75"
          "aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow"
    });
  }

  static sign(String msg) {
    print('msg: Is $msg');
    final Uint8List signature =
        keys.privateKey.createSHA256Signature(utf8.encode(msg) as Uint8List);
    print("SIGN: ${base64.encode(signature)}");
    return (base64.encode(signature));
  }

  static bool verify(String msg, sign, pub) {
    RSAPublicKey public = RSAPublicKey.fromString(pub);
    sign = base64.decode(sign);
    bool verified = public.verifySHA256Signature(
      AESAlg.convertStringToUint8List("msg"),
      sign,
    );
    print("Verified: $verified");
    return verified;
  }
}
