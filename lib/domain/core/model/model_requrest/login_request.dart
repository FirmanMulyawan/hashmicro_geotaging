import 'package:hashmicro/utils/extension/remove_empty_value.dart';

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
      }.removeEmptyValue;
}
