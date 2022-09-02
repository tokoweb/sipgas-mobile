import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:data/other/response_object.dart';

class UpdateProfileRequest extends ResponseObject {
  String? name;
  String? email;
  String? username;
  String? phone;
  dio.MultipartFile? avatar;

  UpdateProfileRequest({
    this.name,
    this.email,
    this.phone,
    this.username,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'avatar': avatar,
    };
  }

  factory UpdateProfileRequest.fromMap(Map<String, dynamic> map) {
    return UpdateProfileRequest(
      name: map['name'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileRequest.fromJson(String source) =>
      UpdateProfileRequest.fromMap(json.decode(source));
}
