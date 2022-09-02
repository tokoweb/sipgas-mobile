import 'dart:convert';

import 'package:data/other/response_object.dart';

class LoginRequest extends ResponseObject {
  String? username;
  String? password;
  String? role;
  String? deviceName;

  LoginRequest(
      {required this.username,
      required this.password,
      required this.role,
      this.deviceName});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'role': role,
      'device_name': deviceName
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
        username: map['username'],
        password: map['password'],
        role: map['role'],
        deviceName: map['device_name']);
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));
}
