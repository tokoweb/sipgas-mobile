import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tube_detail_response.g.dart';

class TubeDetailResponse extends ResponseObject {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tank_category_id')
  int? tankCategoryId;

  @JsonKey(name: 'category_name')
  String? categoryName;

  @JsonKey(name: 'serial_number')
  String? serialNumber;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

   @JsonKey(name: 'message')
  String? message;


  TubeDetailResponse({
    this.id,
    this.tankCategoryId,
    this.categoryName,
    this.serialNumber,
    this.status,
    this.location,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.message,
  });

  factory TubeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TubeDetailResponseFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tank_category_id': tankCategoryId,
      'category_name': categoryName,
      'serial_number': serialNumber,
      'status': status,
      'location': location,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'message': message,      
    };
  }

  String toJson() => json.encode(toMap());

  static get serializer => _$TubeDetailResponseFromJson;
}


