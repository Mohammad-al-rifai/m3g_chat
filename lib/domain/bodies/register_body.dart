class RegisterBody {
  int? phone;
  String? username;
  String? password;

  RegisterBody({this.phone, this.username, this.password});

  RegisterBody.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
