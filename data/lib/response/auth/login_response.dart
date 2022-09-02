import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../other/response_object.dart';

part 'login_response.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponse extends ResponseObject {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'user')
  SubLoginResponse? user;

  LoginResponse({this.message, this.accessToken, this.type, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  static get serializer => _$LoginResponseFromJson;
}

class SubLoginResponse {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? avatarPath;
  String? createdAt;
  String? updatedAt;
  String? avatarUrl;
  String? roleName;
  RoleData? roleData;

  SubLoginResponse({
    this.id,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.avatarPath,
    this.createdAt,
    this.updatedAt,
    this.avatarUrl,
    this.roleName,
    this.roleData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'avatar_path': avatarPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'avatar_url': avatarUrl,
      'role': roleData,
    };
  }

  factory SubLoginResponse.fromMap(Map<String, dynamic> map) {
    return SubLoginResponse(
        id: map['id'],
        name: map['name'],
        username: map['username'],
        email: map['email'],
        emailVerifiedAt: map['email_verified_at'] ?? '',
        phone: map['phone'] ?? '',
        avatarPath: map['avatarPath'] ?? '',
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        avatarUrl: map['avatar_url'] ?? '',
        roleData: map['role'] != null ? RoleData.fromMap(map['role']) : null);
  }

  String toJson() => json.encode(toMap());

  factory SubLoginResponse.fromJson(String source) =>
      SubLoginResponse.fromMap(json.decode(source));
}

class RoleData {
  int? id;
  String? name;
  String? guardName;
  String? label;
  String? createdAt;
  String? updatedAt;

  RoleData({
    this.id,
    this.name,
    this.guardName,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'guard_name': guardName,
      'label': label,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory RoleData.fromMap(Map<String, dynamic> map) {
    return RoleData(
      id: map['id'],
      name: map['name'],
      guardName: map['guard_name'],
      label: map['label'],
      createdAt: map['created_at'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleData.fromJson(String source) =>
      RoleData.fromMap(json.decode(source));
}
