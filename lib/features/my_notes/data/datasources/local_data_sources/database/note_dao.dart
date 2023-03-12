import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note WHERE isDeleted=false')
  Future<List<Note>> getAllNotes();

  @Query('SELECT * FROM Note WHERE isDeleted=false ORDER BY title')
  Future<List<Note>> getAllNotesByTitle();

  @Query('SELECT * FROM Note WHERE isDeleted=false ORDER BY title DESC')
  Future<List<Note>> getAllNotesByTitleDesc();

  @Query('SELECT * FROM Note WHERE isDeleted=false ORDER BY date')
  Future<List<Note>> getAllNotesByDate();

  @Query('SELECT * FROM Note WHERE isDeleted=false ORDER BY date DESC')
  Future<List<Note>> getAllNotesByDateDesc();

  @Query('SELECT * FROM Note WHERE isDeleted=true')
  Future<List<Note>> getAllDeletedNotes();

  @Query('UPDATE Note SET isSelected=false WHERE isSelected=true')
  Future<void> updateSelectedNotes();

  @Query('UPDATE Note SET isDeleted=true WHERE isSelected=true')
  Future<void> removeNote();

  @Query('DELETE FROM Note WHERE isSelected=true')
  Future<void> removeDeletedNotes();

  @Query(
      'SELECT * FROM Note WHERE title LIKE :searchValue OR content LIKE :searchValue')
  Future<List<Note>> getSearchNote(String searchValue);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
