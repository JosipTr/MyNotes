import 'package:floor/floor.dart';

import '../../../models/note_model.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM NoteModel')
  Future<List<NoteModel>> getNotes();

  // @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 AND (title LIKE :searchValue OR content LIKE :searchValue)')
  // Future<List<Note>> getSearchedNotes(String searchValue);

  @delete
  Future<void> removeNote(NoteModel noteModel);

  @insert
  Future<void> insertNote(NoteModel noteModel);

  @update
  Future<void> updateNote(NoteModel noteModel);
}
