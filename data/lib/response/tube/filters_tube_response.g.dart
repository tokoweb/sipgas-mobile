part of 'filters_tube_response.dart';

FiltersTubeResponse _$FiltersTubeResponseFromJson(Map<String, dynamic> json) =>
    FiltersTubeResponse(
      listCategories: json['tank_categories'] == null
          ? null
          : (json['tank_categories'] as List<dynamic>)
              .map((e) =>
                  SubFiltersTubeResponse.fromMap(e as Map<String, dynamic>))
              .toList(),
      listStatus: json['status'] == null
          ? null
          : (json['status'] as List<dynamic>)
              .map((e) =>
                  SubFiltersTubeResponse.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
