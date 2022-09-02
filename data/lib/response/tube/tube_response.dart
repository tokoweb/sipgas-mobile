import 'dart:convert';
import 'package:data/other/response_object.dart';
import 'package:data/response/travel_doc/travel_doc_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tube_response.g.dart';

class TubeResponse extends ResponseObject {
  @JsonKey(name: 'results')
  List<SubTubeResponse>? listTube;

  @JsonKey(name: 'pagination')
  PaginationData? pagination;

  TubeResponse({
    this.listTube,
    this.pagination,
  });

  factory TubeResponse.fromJson(Map<String, dynamic> json) =>
      _$TubeResponseFromJson(json);

  static get serializer => _$TubeResponseFromJson;
}

class SubTubeResponse {
  int? id;
  int? tankCategoryId;
  String? categoryName;
  String? serialNumber;
  String? status;
  String? location;
  String? note;
  String? createdAt;
  String? updatedAt;

  SubTubeResponse({
    required this.id,
    required this.tankCategoryId,
    required this.categoryName,
    required this.serialNumber,
    required this.status,
    required this.location,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

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
    };
  }

  factory SubTubeResponse.fromMap(Map<String, dynamic> map) {
    return SubTubeResponse(
      id: map['id'],
      tankCategoryId: map['tank_category_id'],
      categoryName: map['category_name'],
      serialNumber: map['serial_number'],
      status: map['status'],
      location: map['location'],
      note: map['note'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTubeResponse.fromJson(String source) =>
      SubTubeResponse.fromMap(json.decode(source));
}
