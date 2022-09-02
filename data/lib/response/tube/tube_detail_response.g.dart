part of 'tube_detail_response.dart';

TubeDetailResponse _$TubeDetailResponseFromJson(Map<String, dynamic> json) =>
    TubeDetailResponse(
      id: json['id'] == null ? null : json['id'] as int,
      tankCategoryId: json['tank_category_id'] == null
          ? null
          : json['tank_category_id'] as int,
      categoryName: json['category_name'] == null
          ? null
          : json['category_name'] as String,
      serialNumber: json['serial_number'] == null
          ? null
          : json['serial_number'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      location: json['location'] == null ? null : json['location'] as String,
      note: json['note'] == null ? null : json['note'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      updatedAt:
          json['updated_at'] == null ? null : json['updated_at'] as String,
      message: json['nessage'] == null ? null : json['nessage'] as String,
    );
