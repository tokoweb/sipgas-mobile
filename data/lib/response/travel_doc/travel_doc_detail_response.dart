import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:data/response/travel_doc/travel_doc_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'travel_doc_detail_response.g.dart';

class TravelDocDetailResponse extends ResponseObject {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'tanks_count')
  int? tanksCount;

  @JsonKey(name: 'customer')
  CustomerData? customerData;

  @JsonKey(name: 'tank_categories')
  List<TankCategoriesData>? tankCategoriesData;

  @JsonKey(name: 'notes')
  List<NotesData>? noteData;

  @JsonKey(name: 'driver')
  DriverData? driverData;

  @JsonKey(name: 'vehicle')
  VehicleData? vehicleData;

  @JsonKey(name: 'recipient_name')
  String? recipientName;

  @JsonKey(name: 'attachments')
  List<AttachmentsData>? attachments;

  @JsonKey(name: 'tanks')
  List<AttachmentsData>? tanks;

  TravelDocDetailResponse(
      {this.id,
      this.code,
      this.date,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.tankCategoriesData,
      this.customerData,
      this.tanksCount,
      this.noteData,
      this.driverData,
      this.vehicleData,
      this.recipientName,
      this.attachments});

  factory TravelDocDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TravelDocDetailResponseFromJson(json);

  static get serializer => _$TravelDocDetailResponseFromJson;
}

class NotesData {
  int? id;
  int? deliveryId;
  int? userId;
  String? userName;
  String? userRole;
  String? note;
  String? createdAt;
  String? updatedAt;

  NotesData({
    this.id,
    this.deliveryId,
    this.userId,
    this.userName,
    this.userRole,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'user_id': userId,
      'user_name': userName,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory NotesData.fromMap(Map<String, dynamic> map) {
    return NotesData(
      id: map['id'],
      deliveryId: map['delivery_id'],
      userId: map['user_id'],
      userName: map['user_name'],
      note: map['note'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory NotesData.fromJson(String source) =>
      NotesData.fromMap(json.decode(source));
}

class DriverData {
  int? id;
  int? deliveryId;
  int? userId;
  String? name;
  String? phone;
  String? createdAt;
  String? updatedAt;

  DriverData({
    this.id,
    this.deliveryId,
    this.userId,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory DriverData.fromMap(Map<String, dynamic> map) {
    return DriverData(
      id: map['id'],
      deliveryId: map['delivery_id'],
      userId: map['user_id'],
      name: map['name'],
      phone: map['phone'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DriverData.fromJson(String source) =>
      DriverData.fromMap(json.decode(source));
}

class VehicleData {
  int? id;
  int? deliveryId;
  int? vehicleId;
  String? type;
  String? serialNumber;
  String? licensePlate;
  String? createdAt;
  String? updatedAt;

  VehicleData({
    this.id,
    this.deliveryId,
    this.vehicleId,
    this.type,
    this.serialNumber,
    this.licensePlate,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'vehicle_id': vehicleId,
      'type': type,
      'serial_number': serialNumber,
      'license_plate': licensePlate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory VehicleData.fromMap(Map<String, dynamic> map) {
    return VehicleData(
      id: map['id'],
      deliveryId: map['delivery_id'],
      vehicleId: map['vehicle_id'],
      type: map['type'],
      serialNumber: map['serial_number'],
      licensePlate: map['license_plate'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory VehicleData.fromJson(String source) =>
      VehicleData.fromMap(json.decode(source));
}

class AttachmentsData {
  int? id;
  int? deliveryId;
  String? attachmentPath;
  String? createdAt;
  String? updatedAt;
  String? url;

  AttachmentsData({
    this.id,
    this.deliveryId,
    this.attachmentPath,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'attachment_path': attachmentPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'url': url,
    };
  }

  factory AttachmentsData.fromMap(Map<String, dynamic> map) {
    return AttachmentsData(
      id: map['id'],
      deliveryId: map['delivery_id'],
      attachmentPath: map['attachment_path'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      url: map['url'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AttachmentsData.fromJson(String source) =>
      AttachmentsData.fromMap(json.decode(source));
}

class TubesData {
  int? id;
  int? tankCategoryId;
  String? serialNumber;
  String? status;
  String? location;
  String? note;
  String? createdAt;
  String? updatedAt;

  TubesData({
    this.id,
    this.tankCategoryId,
    this.serialNumber,
    this.status,
    this.location,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tank_category_id': tankCategoryId,
      'serial_number': serialNumber,
      'status': status,
      'location': location,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TubesData.fromMap(Map<String, dynamic> map) {
    return TubesData(
      id: map['id'],
      tankCategoryId: map['tank_category_id'],
      serialNumber: map['serial_number'],
      status: map['status'],
      location: map['location'],
      note: map['note'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory TubesData.fromJson(String source) =>
      TubesData.fromMap(json.decode(source));
}
