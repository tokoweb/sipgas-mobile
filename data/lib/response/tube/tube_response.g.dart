part of 'tube_response.dart';

TubeResponse _$TubeResponseFromJson(Map<String, dynamic> json) => TubeResponse(
    listTube: json['results'] == null
        ? null
        : (json['results'] as List<dynamic>)
            .map((e) => SubTubeResponse.fromMap(e as Map<String, dynamic>))
            .toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationData.fromMap(json['pagination'] as Map<String, dynamic>));
