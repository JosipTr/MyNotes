import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getNotes();

  // @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 AND (title LIKE :searchValue OR content LIKE :searchValue)')
  // Future<List<Note>> getSearchedNotes(String searchValue);

  @delete
  Future<void> removeNote(Note note);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
