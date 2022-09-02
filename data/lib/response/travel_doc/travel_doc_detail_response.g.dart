part of 'travel_doc_detail_response.dart';

TravelDocDetailResponse _$TravelDocDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TravelDocDetailResponse(
      id: json['id'] == null ? null : json['id'] as int,
      code: json['code'] == null ? null : json['code'] as String,
      date: json['date'] == null ? null : json['date'] as String,
      type: json['type'] == null ? null : json['type'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      updatedAt:
          json['updated_at'] == null ? null : json['updated_at'] as String,
      customerData: json['customer'] == null
          ? null
          : CustomerData.fromMap(json['customer'] as Map<String, dynamic>),
      tankCategoriesData: json['tank_categories'] == null
          ? null
          : (json['tank_categories'] as List<dynamic>)
              .map((e) => TankCategoriesData.fromMap(e as Map<String, dynamic>))
              .toList(),
      tanksCount:
          json['tanks_count'] == null ? null : json['tanks_count'] as int,
      noteData: json['notes'] == null
          ? null
          : (json['notes'] as List<dynamic>)
              .map((e) => NotesData.fromMap(e as Map<String, dynamic>))
              .toList(),
      driverData: json['driver'] == null
          ? null
          : DriverData.fromMap(json['driver'] as Map<String, dynamic>),
      vehicleData: json['vehicle'] == null
          ? null
          : VehicleData.fromMap(json['vehicle'] as Map<String, dynamic>),
      recipientName: json['recipient_name'] == null
          ? null
          : json['recipient_name'] as String,
      attachments: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>)
              .map((e) => AttachmentsData.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
