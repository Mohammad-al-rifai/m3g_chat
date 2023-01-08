import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:pointycastle/asymmetric/api.dart';

class PGPAlGO {
  static Future<String> encryptSession() async {
    final publicPem = await rootBundle.loadString('assets/public.pem');
    final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;


    final privatePem = await rootBundle.loadString('assets/private.pem');
    final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;


    final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
    String plainText = getRandomSessionKey();
    AppConstants.random = plainText;
    final encrypted = encrypter.encrypt(plainText);
    return encrypted.base64;
  }

  static String getRandomSessionKey() {
    var generator = RandomStringGenerator(
      mustHaveAtLeastOneOfEach: true,
      hasAlpha: true,
      alphaCase: AlphaCase.UPPERCASE_ONLY,
      hasDigits: true,
      hasSymbols: true,
      fixedLength: 32,
    );
    return generator.generate();
  }
}
