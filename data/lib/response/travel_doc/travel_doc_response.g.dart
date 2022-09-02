part of 'travel_doc_response.dart';

TravelDocResponse _$TravelDocResponseFromJson(Map<String, dynamic> json) =>
    TravelDocResponse(
        listTravelDoc: json['results'] == null
            ? null
            : (json['results'] as List<dynamic>)
                .map((e) =>
                    SubTravelDocResponse.fromMap(e as Map<String, dynamic>))
                .toList(),
        pagination: json['pagination'] == null
            ? null
            : PaginationData.fromMap(
                json['pagination'] as Map<String, dynamic>));
