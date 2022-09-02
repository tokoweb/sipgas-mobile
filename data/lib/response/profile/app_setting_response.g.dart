part of 'app_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingResponse _$AppSettingResponseFromJson(Map<String, dynamic> json) =>
    AppSettingResponse(
      id: json['id'] == null ? null : json['id'] as int,
      appName: json['app_ame'] == null ? null : json['app_name'] as String,
      about: json['about'] == null ? null : json['about'] as String,
      terms: json['terms'] == null ? null : json['terms'] as String,
      privacyPolicy: json['privacy_policy'] == null
          ? null
          : json['privacy_policy'] as String,
      whatsapp: json['whatsapp'] == null ? null : json['whatsapp'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      updatedAt:
          json['updated_at'] == null ? null : json['updated_at'] as String,
    );
