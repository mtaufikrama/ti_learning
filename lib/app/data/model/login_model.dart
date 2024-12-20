class LoginModel {
  String? expiresOn;
  String? token;
  User? user;
  String? userId;

  LoginModel({this.expiresOn, this.token, this.user, this.userId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    expiresOn = json['expiresOn'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiresOn'] = expiresOn;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  List<String>? role;

  User(
      {this.sId,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    role = json['role'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    return data;
  }
}
