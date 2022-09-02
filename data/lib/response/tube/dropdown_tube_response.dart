import 'package:data/other/response_object.dart';
import 'package:data/response/travel_doc/dropdown_driver_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dropdown_tube_response.g.dart';

class DropdownTubeResponse extends ResponseObject {
  @JsonKey(name: 'tank_categories')
  List<DropdownData>? tankCategories;

  @JsonKey(name: 'status')
  List<DropdownData>? status;

  DropdownTubeResponse({
    this.tankCategories,
    this.status,
  });

  factory DropdownTubeResponse.fromJson(Map<String, dynamic> json) =>
      _$DropdownTubeResponseFromJson(json);

  static get serializer => _$DropdownTubeResponseFromJson;
}
