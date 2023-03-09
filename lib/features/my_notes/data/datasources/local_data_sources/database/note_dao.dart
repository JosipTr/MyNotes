import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getAllNotes();

  @Query(
      'UPDATE Note SET isSelected=:isSelectedOne WHERE isSelected= :isSelectedTwo')
  Future<void> updateSelectedNotes(bool isSelectedOne, bool isSelectedTwo);

  @Query('DELETE FROM Note WHERE isSelected=:isSelected')
  Future<void> removeNote(bool isSelected);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
