part of 'filter_response.dart';

FilterResponse _$FilterResponseFromJson(Map<String, dynamic> json) =>
    FilterResponse(
      listFilter: json['tank_categories'] == null
          ? null
          : (json['tank_categories'] as List<dynamic>)
              .map((e) => SubFilterResponse.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
