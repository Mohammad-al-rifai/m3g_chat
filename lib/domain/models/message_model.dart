import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import '../../app/encryption/SignAndVerify.dart';
import '../../app/encryption/aes.dart';

class MessageModel {
  String? from;
  String? to;
  String? message;
  String? mac;
  String? pubKey;
  String? signature;
  bool Verified = false;

  MessageModel({this.from, this.to, this.message, this.mac});

  MessageModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];

    to = json['to'];
    message = json['message'];
    mac = json['mac'];
    if (AppConstants.level == 4) {
      print("object");
      signature = json['signature'];
      pubKey = json['pubKey'];
      var temp = AESAlg.decryption(
        cipherText: base64.encode(decodeHexString(message!)),
      );
      Verified = Rsa.verify(temp.toString(), signature, pubKey!);
      print('++++++++++++++++++++++++=Level #4=+++++++++++++++++++++++++++++++');
      print(Verified);
      print('++++++++++++++++++++++++=Level #4=+++++++++++++++++++++++++++++++');

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['message'] = message;
    data['mac'] = mac;
    if (AppConstants.level == 4) {
      data['signature'] = signature;
      print(Rsa.keys.publicKey.toString());
      data['pubKey'] = Rsa.keys.publicKey.toString();
    }
    return data;
  }
}
