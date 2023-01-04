import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:m3g_chat/app/encryption/aes.dart';

import '../../app/components/resources/constants_manager.dart';
import '../../app/encryption/SignAndVerify.dart';

class ChatMessageModel {
  String? sId;
  String? chatId;
  From? from;
  From? to;
  String? message;
  int? sendAt;
  int? iV;
  String? pubKey;
  String? signature;
  bool Verified = false;

  ChatMessageModel(
      {this.sId,
      this.chatId,
      this.from,
      this.to,
      this.message,
      this.sendAt,
      this.iV});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    if (AppConstants.level == 4) {
      sId = json['sentMessage']['_id'];
      chatId = json['sentMessage']['chatId'];
      from = json['sentMessage']['from'] != null
          ? From.fromJson(json['sentMessage']['from'])
          : null;
      to = json['sentMessage']['to'] != null
          ? From.fromJson(json['sentMessage']['to'])
          : null;
      message = json['sentMessage']['message'];
      print('Resi Message : $message');
      sendAt = json['sentMessage']['sendAt'];
      iV = json['sentMessage']['__v'];
      signature = json['signature'];
      pubKey = json['pubKey'];

      Verified = Rsa.verify(
          AESAlg.decryption(
              cipherText:
                  base64.encode(decodeHexString(message ?? 'No Message'))),
          signature,
          pubKey ?? 'noPub');
      print('**************************************************************');
      print(pubKey);
      print(signature);
      print(Verified);
      print('**************************************************************');
    } else {
      sId = json['_id'];
      chatId = json['chatId'];
      from = json['from'] != null ? From.fromJson(json['from']) : null;
      to = json['to'] != null ? From.fromJson(json['to']) : null;
      message = json['message'];
      print('Resi Message : $message');
      sendAt = json['sendAt'];
      iV = json['__v'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['chatId'] = chatId;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['message'] = message;
    data['sendAt'] = sendAt;
    data['__v'] = iV;
    return data;
  }
}

class From {
  String? sId;
  int? phone;
  String? username;
  int? createdAt;
  int? iV;

  From({this.sId, this.phone, this.username, this.createdAt, this.iV});

  From.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    username = json['username'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone'] = phone;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
