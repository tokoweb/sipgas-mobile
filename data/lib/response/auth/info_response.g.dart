part of 'info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoResponse _$InfoResponseFromJson(Map<String, dynamic> json) => InfoResponse(
      id: json['id'] == null ? null : json['id'] as int,
      username: json['username'] == null ? null : json['username'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : json['email_verified_at'] as String,
      phone: json['phone'] == null ? null : json['phone'] as String,
      avatarPath:
          json['avatar_path'] == null ? null : json['avatar_path'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      updatedAt:
          json['updated_at'] == null ? null : json['updated_at'] as String,
      avatarUrl:
          json['avatar_url'] == null ? null : json['avatar_url'] as String,
      roleData: json['role'] == null
          ? null
          : RoleData.fromMap(json['role'] as Map<String, dynamic>),
    );
