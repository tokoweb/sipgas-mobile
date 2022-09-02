import 'dart:convert';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';
import 'package:data/util/table_sariangin.dart';

class TubeDao {
  int? id;
  int tubeId;
  int tankCategoryId;
  String categoryName;
  String serialNumber;
  String status;
  String location;
  String note;
  String userId;

  TubeDao(
      {this.id = null,
      this.tubeId = 0,
      this.tankCategoryId = 0,
      this.categoryName = "",
      this.serialNumber = "",
      this.status = "",
      this.location = "",
      this.note = "",
      this.userId = ""});

  Map<String, dynamic> toMap() {
    return {
      Util.ENTITY_ID: id,
      Util.ENTITY_TUBE_ID: tubeId,
      Util.ENTITY_TUBE_CATEGORY_ID: tankCategoryId,
      Util.ENTITY_TUBE_CATEGORY_NAME: categoryName,
      Util.ENTITY_TUBE_SERIAL_NUMBER: serialNumber,
      Util.ENTITY_TUBE_STATUS: status,
      Util.ENTITY_TUBE_LOCATION: location,
      Util.ENTITY_TUBE_NOTE: note,
      Util.ENTITY_TUBE_USER_ID: userId,
    };
  }

  factory TubeDao.fromMap(Map<String, dynamic> map) {
    return TubeDao(
      id: map[Util.ENTITY_ID],
      tubeId: map[Util.ENTITY_TUBE_ID],
      tankCategoryId: map[Util.ENTITY_TUBE_CATEGORY_ID],
      categoryName: map[Util.ENTITY_TUBE_CATEGORY_NAME],
      serialNumber: map[Util.ENTITY_TUBE_SERIAL_NUMBER],
      status: map[Util.ENTITY_TUBE_STATUS],
      location: map[Util.ENTITY_TUBE_LOCATION],
      note: map[Util.ENTITY_TUBE_NOTE],
      userId: map[Util.ENTITY_TUBE_USER_ID],
    );
  }

  String toJson() => json.encode(toMap());

  factory TubeDao.fromJson(String source) =>
      TubeDao.fromMap(json.decode(source));

  factory TubeDao.fromTubeResponse(String userId, SubTubeResponse data) {
    return TubeDao(
      tubeId: data.id != null ? data.id!.toInt() : 0,
      tankCategoryId:
          data.tankCategoryId != null ? data.tankCategoryId!.toInt() : 0,
      categoryName: data.categoryName != null ? data.categoryName! : "",
      serialNumber: data.serialNumber != null ? data.serialNumber! : "",
      status: data.status != null ? data.status! : "",
      location: data.location != null ? data.location! : "",
      note: data.note != null ? data.note! : "",
    );
  }

  factory TubeDao.fromTubeDetailResponse(TubeDetailResponse data) {
    return TubeDao(
        tubeId: data.id != null ? data.id!.toInt() : 0,
        tankCategoryId:
            data.tankCategoryId != null ? data.tankCategoryId!.toInt() : 0,
        categoryName: data.categoryName != null ? data.categoryName! : "",
        serialNumber: data.serialNumber != null ? data.serialNumber! : "",
        status: data.status != null ? data.status! : "",
        location: data.location != null ? data.location! : "",
        note: data.note != null ? data.note! : "");
  }
}
