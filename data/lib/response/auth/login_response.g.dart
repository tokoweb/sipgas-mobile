part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] == null ? null : json['message'] as String,
      accessToken:
          json['access_token'] == null ? null : json['access_token'] as String,
      type: json['type'] == null ? null : json['type'] as String,
      user: json['user'] == null
          ? null
          : SubLoginResponse.fromMap(json['user'] as Map<String, dynamic>),
    );
