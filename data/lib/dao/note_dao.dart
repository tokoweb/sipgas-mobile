import 'dart:convert';
import 'package:data/util/table_sariangin.dart';

class NoteDao {
  int? id;
  String? desc;
  String? name;

  NoteDao({this.id, this.desc, this.name});

  Map<String, dynamic> toMap() {
    return {
      Util.ENTITY_NOTE_ID: id,
      Util.ENTITY_NOTE_DESC: desc,
      Util.ENTITY_NOTE_NAME: name,
    };
  }

  factory NoteDao.fromMap(Map<String, dynamic> map) {
    return NoteDao(
        id: map[Util.ENTITY_NOTE_ID],
        desc: map[Util.ENTITY_NOTE_DESC],
        name: map[Util.ENTITY_NOTE_NAME]);
  }

  Map<String, dynamic> toJson() => toMap();

  factory NoteDao.fromJson(String source) =>
      NoteDao.fromMap(json.decode(source));
}
