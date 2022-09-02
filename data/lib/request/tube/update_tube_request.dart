import 'dart:convert';

import 'package:data/other/response_object.dart';

class UpdateTubeRequest extends ResponseObject {
  String? tubeId;
  int? tankCategoryId;
  String? serialNumber;
  String? status;
  String? location;
  String? note;

  UpdateTubeRequest({
    this.tubeId,
    required this.tankCategoryId,
    required this.serialNumber,
    required this.status,
    required this.location,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'tank_category_id': tankCategoryId,
      'serial_number': serialNumber,
      'status': status,
      'location': location,
      'note': note,
    };
  }

  factory UpdateTubeRequest.fromMap(Map<String, dynamic> map) {
    return UpdateTubeRequest(
      tankCategoryId: map['tank_category_id'],
      serialNumber: map['serial_number'],
      status: map['status'],
      location: map['location'],
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateTubeRequest.fromJson(String source) =>
      UpdateTubeRequest.fromMap(json.decode(source));
}
