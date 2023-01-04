class AllUsersModel {
  List<Users>? users;

  AllUsersModel({this.users});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? sId;
  var phone;
  String? username;
  int? createdAt;
  int? iV;
  List<String>? messages = [];

  Users({this.sId, this.phone, this.username, this.createdAt, this.iV});

  Users.fromJson(Map<String, dynamic> json) {
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
