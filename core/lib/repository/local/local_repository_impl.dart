import 'package:core/domain/repo/local_repository.dart';
import 'package:core/repository/local/sqlite/db_helper.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:data/dao/note_dao.dart';

class LocalRepositoryImpl implements LocalRepository {
  final DBHelper dbHelper;

  LocalRepositoryImpl({required this.dbHelper});

  @override
  Future<int> tubeAction(TubeDao tube) {
    return dbHelper.tubeAction(tube);
  }

  @override
  Future<List<TubeDao>> getTubeByUser(String userId) {
    return dbHelper.getTubeByUser(userId);
  }

  @override
  Future<int> deleteTube(String id, String userId) {
    return dbHelper.deleteTube(id, userId);
  }

  @override
  Future<int> updateNoteTube(int tubeId, String userId, String note) {
    return dbHelper.updateNoteTube(tubeId, userId, note);
  }

  @override
  Future<int> deleteAllTube() {
    return dbHelper.deleteAllTube();
  }

  @override
  Future<int> insertNoteTravelDoc(NoteDao noteDao) {
    return dbHelper.insertNote(noteDao);
  }

  @override
  Future<List<NoteDao>> getAllNoteDao() {
    return dbHelper.getNoteList();
  }

  @override
  Future<int> updateNoteTravelDoc(NoteDao noteDao) {
    return dbHelper.updateNote(noteDao);
  }

  @override
  Future<int> deleteNoteTravelDoc() {
    return dbHelper.deleteAllNote();
  }
}
