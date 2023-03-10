import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note ORDER BY date DESC')
  Future<List<Note>> getAllNotes();

  @Query('UPDATE Note SET isSelected=false WHERE isSelected=true')
  Future<void> updateSelectedNotes();

  @Query('DELETE FROM Note WHERE isSelected=true')
  Future<void> removeNote();

  @Query(
      'SELECT * FROM Note WHERE title LIKE :searchValue OR content LIKE :searchValue')
  Future<List<Note>> getSearchNote(String searchValue);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
