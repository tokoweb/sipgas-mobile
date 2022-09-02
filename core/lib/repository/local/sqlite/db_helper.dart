import 'package:data/dao/note_dao.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:data/util/table_sariangin.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final Database database;

  DBHelper({required this.database});

  Future<bool> checkTubeIsExists(int tubeId, String userId) async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query(Util.TABLE_SCAN_TUBE,
        where:
            "${Util.ENTITY_TUBE_ID} = $tubeId AND ${Util.ENTITY_TUBE_USER_ID} = $userId");
    debugPrint("list tube : ${maps.length}");
    var tube = List.generate(maps.length, (i) {
      return TubeDao.fromMap(maps[i]);
    });

    return tube.isNotEmpty;
  }

  Future<int> tubeAction(TubeDao tube) async {
    final db = database;

    debugPrint("Tube add hit : Hit");
    var favoriteIsExists = await checkTubeIsExists(tube.tubeId, tube.userId);

    if (!favoriteIsExists) {
      debugPrint("kosong ${tube.toJson()}");
      int count = await db.insert(
        Util.TABLE_SCAN_TUBE,
        tube.toMap(),
      );

      return count;
    }
    return 0;
  }

  Future<List<TubeDao>> getTubeById(int tubeId, String userId) async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query(Util.TABLE_SCAN_TUBE,
        where:
            "${Util.ENTITY_ID} = $tubeId AND ${Util.ENTITY_TUBE_USER_ID} = $userId");
    debugPrint("Tube : ${maps.length}");
    return List.generate(maps.length, (i) {
      return TubeDao.fromMap(maps[i]);
    });
  }

  Future<List<TubeDao>> getTubeByUser(String userId) async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query(Util.TABLE_SCAN_TUBE,
        where: "${Util.ENTITY_TUBE_USER_ID} = $userId");
    return List.generate(maps.length, (i) {
      return TubeDao.fromMap(maps[i]);
    });
  }

  Future<int> deleteTube(String id, String userId) async {
    final db = database;
    debugPrint("TUBE ID DB HELPER $id, ID USER $userId");

    var checkTube = await getTubeById(int.parse(id), userId.toString());
    if (checkTube.isNotEmpty) {
      debugPrint("ada data ${checkTube.length}");

      var tubeDataCheck = checkTube[0];
      debugPrint(
          "ada data ${tubeDataCheck.serialNumber}/${tubeDataCheck.categoryName}");

      int count = await db.delete(Util.TABLE_SCAN_TUBE,
          where:
              "${Util.ENTITY_ID} = $id AND ${Util.ENTITY_TUBE_USER_ID} = $userId");
      return count;
    } else {
      debugPrint("Tidak ada data");
      return 0;
    }
  }

  Future<int> updateNoteTube(int tubeId, String userId, String note) async {
    final db = database;
    var checkTube = await getTubeById(tubeId, userId);
    if (checkTube.isNotEmpty) {
      int updateCount = await db.rawUpdate('''
    UPDATE ${Util.TABLE_SCAN_TUBE}
    SET ${Util.ENTITY_TUBE_NOTE} = ?
    WHERE ${Util.ENTITY_ID} = ?
    ''', [note, checkTube[0].id]);
      return updateCount;
    } else {
      return 0;
    }
  }

  Future<int> deleteAllTube() async {
    final db = database;
    var result = await db.delete(Util.TABLE_SCAN_TUBE);

    return result;
  }

  Future<int> insertNote(NoteDao noteDao) async {
    final db = database;
    return await db.insert(Util.TABLE_NOTE, noteDao.toJson());
  }

  Future<int> updateNote(NoteDao noteDao) async {
    final db = database;

    return await db.update(
      Util.TABLE_NOTE,
      noteDao.toJson(),
      where: "id = ?",
      whereArgs: [noteDao.id],
    );
  }

  Future<List<NoteDao>> getNoteList() async {
    final db = database;
    final List<Map<String, dynamic>> results = await db.query(Util.TABLE_NOTE);
    return results.map((data) => NoteDao.fromMap(data)).toList();
  }

  Future<int> deleteAllNote() async {
    final db = database;
    var result = await db.delete(Util.TABLE_NOTE);
    return result;
  }
}
