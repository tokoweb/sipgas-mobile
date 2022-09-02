import 'dart:convert';
import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_tube_response.g.dart';

class FiltersTubeResponse extends ResponseObject {
  @JsonKey(name: 'tank_categories')
  List<SubFiltersTubeResponse>? listCategories;

  @JsonKey(name: 'status')
  List<SubFiltersTubeResponse>? listStatus;

  FiltersTubeResponse({
    this.listCategories,
    this.listStatus,
  });

  factory FiltersTubeResponse.fromJson(Map<String, dynamic> json) =>
      _$FiltersTubeResponseFromJson(json);

  static get serializer => _$FiltersTubeResponseFromJson;
}

class SubFiltersTubeResponse {
  String? label;
  dynamic value;

  SubFiltersTubeResponse({
    this.label,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory SubFiltersTubeResponse.fromMap(Map<String, dynamic> map) {
    return SubFiltersTubeResponse(
      label: map['label'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubFiltersTubeResponse.fromJson(String source) =>
      SubFiltersTubeResponse.fromMap(json.decode(source));
}
