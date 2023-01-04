class HMacModel {
  String? from;
  String? to;
  String? message;

  HMacModel({this.from, this.to, this.message});

  HMacModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['message'] = message;
    return data;
  }
}
