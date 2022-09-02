part of 'dropdown_tube_response.dart';

DropdownTubeResponse _$DropdownTubeResponseFromJson(
        Map<String, dynamic> json) =>
    DropdownTubeResponse(
      tankCategories: json['tank_categories'] == null
          ? null
          : (json['tank_categories'] as List<dynamic>)
              .map((e) => DropdownData.fromMap(e as Map<String, dynamic>))
              .toList(),
      status: json['status'] == null
          ? null
          : (json['status'] as List<dynamic>)
              .map((e) => DropdownData.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
