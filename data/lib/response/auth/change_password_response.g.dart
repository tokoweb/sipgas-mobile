part of 'change_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
        message: json['message'] == null ? null : json['message'] as String,
        errors: json['errors'] == null
            ? null
            : ErrorsData.fromMap(json['errors'] as Map<String, dynamic>));
