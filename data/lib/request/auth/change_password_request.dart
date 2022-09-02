import 'dart:convert';

import 'package:data/other/response_object.dart';

class ChangePasswordRequest extends ResponseObject {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  ChangePasswordRequest({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };
  }

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      currentPassword: map['current_password'],
      newPassword: map['new_password'],
      confirmPassword: map['new_password_confirmation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordRequest.fromJson(String source) =>
      ChangePasswordRequest.fromMap(json.decode(source));
}
