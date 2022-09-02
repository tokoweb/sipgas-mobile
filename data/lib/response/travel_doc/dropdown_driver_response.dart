import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dropdown_driver_response.g.dart';

class DropdownDriverResponse extends ResponseObject {
  @JsonKey(name: 'drivers')
  List<DropdownData>? drivers;

  @JsonKey(name: 'vehicles')
  List<DropdownData>? vehicles;

  DropdownDriverResponse({
    this.drivers,
    this.vehicles,
  });

  factory DropdownDriverResponse.fromJson(Map<String, dynamic> json) =>
      _$DropdownDriverResponseFromJson(json);

  static get serializer => _$DropdownDriverResponseFromJson;
}

class DropdownData {
  String? label;
  dynamic value;

  DropdownData({
    this.label,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory DropdownData.fromMap(Map<String, dynamic> map) {
    return DropdownData(
      label: map['label'],
      value: map['value'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DropdownData.fromJson(String source) =>
      DropdownData.fromMap(json.decode(source));
}
