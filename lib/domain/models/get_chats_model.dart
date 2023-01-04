class GetChatsModel {
  List<OneChatMessages>? messages;

  GetChatsModel({this.messages});

  GetChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <OneChatMessages>[];
      json['messages'].forEach((v) {
        messages!.add(OneChatMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OneChatMessages {
  String? sId;
  String? chatId;
  From? from;
  From? to;
  String? message;
  int? sendAt;
  int? iV;

  OneChatMessages(
      {this.sId,
      this.chatId,
      this.from,
      this.to,
      this.message,
      this.sendAt,
      this.iV});

  OneChatMessages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatId = json['chatId'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    message = json['message'];
    sendAt = json['sendAt'];
    iV = json['__v'];
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
