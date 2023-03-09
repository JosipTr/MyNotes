import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getAllNotes();

  @Query('UPDATE Note SET isSelected=false WHERE isSelected=true')
  Future<void> updateSelectedNotes();

  @Query('DELETE FROM Note WHERE isSelected=true')
  Future<void> removeNote();

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
