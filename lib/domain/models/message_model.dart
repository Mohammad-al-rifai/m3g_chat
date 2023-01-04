class MessageModel {
  String? from;
  String? to;
  String? message;
  String? mac;

  MessageModel({this.from, this.to, this.message, this.mac});

  MessageModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    message = json['message'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['message'] = message;
    data['mac'] = mac;
    return data;
  }
}
