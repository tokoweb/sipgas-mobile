import 'dart:convert';

import 'package:data/other/response_object.dart';

class UpdateTravelDocRequest extends ResponseObject {
  List<TankCategoryData>? tanksData;
  String? note;
  int? driverId;
  int? vehicleId;
  List<dynamic>? categoryId;
  String? recipientName;

  UpdateTravelDocRequest({
    this.tanksData,
    this.note,
    this.driverId,
    this.vehicleId,
    this.categoryId,
    this.recipientName,
  });

  Map<String, dynamic> toMap() {
    return {
      'tanks': tanksData!.map(
        (e) {
          return {
            "tank_category_id": e.tankCategoryId,
            "tanks": e.tanks!.map(
              (tanks) {
                return {
                  "serial_number": tanks.serialNumber,
                  "note": tanks.note
                };
              },
            ).toList(),
          };
        },
      ).toList(),
      'note': note,
      'driver_id': driverId,
      'vehicle_id': vehicleId,
      'recipient_name': recipientName,
    };
  }

  factory UpdateTravelDocRequest.fromMap(Map<String, dynamic> map) {
    return UpdateTravelDocRequest(
      tanksData: map['tanks'],
      note: map['note'],
      driverId: map['driver_id'],
      vehicleId: map['vehicle_id'],
      recipientName: map['recipient_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateTravelDocRequest.fromJson(String source) =>
      UpdateTravelDocRequest.fromMap(json.decode(source));
}

class TankCategoryData {
  int tankCategoryId;
  List<TanksData>? tanks;

  TankCategoryData({
    required this.tankCategoryId,
    required this.tanks,
  });

  Map<String, dynamic> toMap() {
    return {
      'tank_category_id': tankCategoryId,
      'tanks': tanks!.map((e) {
        return {"serial_number": e.serialNumber, "note": e.note};
      }).toList(),
    };
  }

  factory TankCategoryData.fromMap(Map<String, dynamic> map) {
    return TankCategoryData(
      tankCategoryId: map['tank_category_id'],
      tanks: map['tanks'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TankCategoryData.fromJson(String source) =>
      TankCategoryData.fromMap(json.decode(source));
}

class TanksData {
  String serialNumber;
  int? tankCategoriesId;
  String? status;
  String note;

  TanksData({
    required this.serialNumber,
    this.tankCategoriesId,
    this.status,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'serial_number': serialNumber,
      'tank_category_id': tankCategoriesId,
      'status': status,
      'note': note,
    };
  }

  factory TanksData.fromMap(Map<String, dynamic> map) {
    return TanksData(
      serialNumber: map['serial_number'],
      tankCategoriesId: map['tank_category_id'],
      status: map['status'],
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TanksData.fromJson(String source) =>
      TanksData.fromMap(json.decode(source));
}
