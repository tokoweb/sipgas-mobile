import 'dart:convert';
import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_response.g.dart';

class FilterResponse extends ResponseObject {
  @JsonKey(name: 'tank_categories')
  List<SubFilterResponse>? listFilter;

  FilterResponse({
    this.listFilter,
  });

  factory FilterResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterResponseFromJson(json);

  static get serializer => _$FilterResponseFromJson;
}

class SubFilterResponse {
  String? label;
  int? value;

  SubFilterResponse({
    this.label,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory SubFilterResponse.fromMap(Map<String, dynamic> map) {
    return SubFilterResponse(
      label: map['label'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubFilterResponse.fromJson(String source) =>
      SubFilterResponse.fromMap(json.decode(source));
}
