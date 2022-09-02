import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:data/request/travel_doc/update_travel_doc_request.dart';

class ScanTubeRequest extends ResponseObject {
  List<TanksData>? tanksData;
  String? comment;
  String? status;

  ScanTubeRequest({this.tanksData, this.comment, this.status});

  Map<String, dynamic> toMap() {
    return {
      'tanks': tanksData!.map((e) {
        return {
          "serial_number": e.serialNumber,
          "tank_category_id": e.tankCategoriesId,
          "status": e.status,
          "note": e.note
        };
      }).toList(),
      '_comment': comment,
      "status": status,
    };
  }

  factory ScanTubeRequest.fromMap(Map<String, dynamic> map) {
    return ScanTubeRequest(
        tanksData: map['tanks'],
        comment: map['comment'],
        status: map['status']);
  }

  String toJson() => json.encode(toMap());

  factory ScanTubeRequest.fromJson(String source) =>
      ScanTubeRequest.fromMap(json.decode(source));
}
