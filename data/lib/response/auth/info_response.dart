import 'dart:convert';

import 'package:data/response/auth/login_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../other/response_object.dart';

part 'info_response.g.dart';

@JsonSerializable(createToJson: false)
class InfoResponse extends ResponseObject {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'avatar_path')
  String? avatarPath;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  @JsonKey(name: 'role')
  RoleData? roleData;

  InfoResponse({
    this.id,
    this.username,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.avatarPath,
    this.createdAt,
    this.updatedAt,
    this.avatarUrl,
    this.roleData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
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

  String toJson() => json.encode(toMap());

  factory InfoResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoResponseFromJson(json);

  static get serializer => _$InfoResponseFromJson;
}
