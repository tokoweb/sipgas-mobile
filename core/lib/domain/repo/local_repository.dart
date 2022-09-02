import 'package:data/dao/note_dao.dart';
import 'package:data/dao/tube_dao.dart';

abstract class LocalRepository {
  Future<int> tubeAction(TubeDao product);
  Future<List<TubeDao>> getTubeByUser(String userId);
  Future<int> deleteTube(String id, String userId);
  Future<int> updateNoteTube(int tubeId, String userId, String note);
  Future<int> deleteAllTube();
  Future<int> insertNoteTravelDoc(NoteDao noteDao);
  Future<List<NoteDao>> getAllNoteDao();
  Future<int> updateNoteTravelDoc(NoteDao noteDao);
  Future<int> deleteNoteTravelDoc();
}
