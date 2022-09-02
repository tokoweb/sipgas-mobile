import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../other/response_object.dart';

part 'change_password_response.g.dart';

@JsonSerializable(createToJson: false)
class ChangePasswordResponse extends ResponseObject {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'errors')
  ErrorsData? errors;

  ChangePasswordResponse({
    this.message,
    this.errors,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  static get serializer => _$ChangePasswordResponseFromJson;
}

class ErrorsData {
  List<dynamic>? currentPassword;

  ErrorsData({
    this.currentPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_password': currentPassword,
    };
  }

  factory ErrorsData.fromMap(Map<String, dynamic> map) {
    return ErrorsData(
      currentPassword: map['current_password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorsData.fromJson(String source) =>
      ErrorsData.fromMap(json.decode(source));
}
