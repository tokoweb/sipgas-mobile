import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../other/response_object.dart';

part 'app_setting_response.g.dart';

class AppSettingResponse extends ResponseObject {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'app_name')
  String? appName;

  @JsonKey(name: 'about')
  String? about;

  @JsonKey(name: 'terms')
  String? terms;

  @JsonKey(name: 'privacy_policy')
  String? privacyPolicy;

  @JsonKey(name: 'whatsapp')
  String? whatsapp;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  AppSettingResponse({
    this.id,
    this.appName,
    this.about,
    this.terms,
    this.privacyPolicy,
    this.whatsapp,
    this.createdAt,
    this.updatedAt,
  });

  factory AppSettingResponse.fromJson(Map<String, dynamic> json) =>
      _$AppSettingResponseFromJson(json);

  static get serializer => _$AppSettingResponseFromJson;
}
