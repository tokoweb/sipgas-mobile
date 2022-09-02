part of 'dropdown_driver_response.dart';

DropdownDriverResponse _$DropdownDriverResponseFromJson(
        Map<String, dynamic> json) =>
    DropdownDriverResponse(
      drivers: json['drivers'] == null
          ? null
          : (json['drivers'] as List<dynamic>)
              .map((e) => DropdownData.fromMap(e as Map<String, dynamic>))
              .toList(),
      vehicles: json['vehicles'] == null
          ? null
          : (json['vehicles'] as List<dynamic>)
              .map((e) => DropdownData.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
