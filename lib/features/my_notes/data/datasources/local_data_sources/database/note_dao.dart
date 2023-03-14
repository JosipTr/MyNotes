import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query(
      'SELECT * FROM Note WHERE isDeleted=0 ORDER BY CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END')
  Future<List<Note>> getNotes(String sortType);

  @Query('SELECT * FROM Note WHERE isDeleted=1 ORDER BY :sortType')
  Future<List<Note>> getDeletedNotes(String sortType);

  @Query(
      'SELECT * FROM Note WHERE title LIKE :searchValue OR content LIKE :searchValue')
  Future<List<Note>> getSearchedNotes(String searchValue);

  @Query('UPDATE Note SET isSelected=0')
  Future<void> unselectAllNotes();

  @Query('UPDATE Note SET isSelected=1 WHERE isDeleted=0')
  Future<void> selectAllNotes();

  @Query(
      'UPDATE Note SET isSelected=CASE WHEN isSelected=1 THEN 0 ELSE 1 END WHERE id=:id')
  Future<void> selectNote(int id);

  @Query('UPDATE Note SET isDeleted=1 WHERE isSelected=1')
  Future<void> setNoteDeleted();

  @Query('UPDATE Note SET isDeleted=0 WHERE isSelected=1')
  Future<void> setNoteUndeleted();

  @Query('DELETE FROM Note WHERE isDeleted=true')
  Future<void> removeNotes();

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNoteContent(Note note);
}
//valja
  // @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 ORDER BY CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END ASC')
  // Future<List<Note>> getNotes(String sortType);


  //   @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 ORDER BY CASE :sortOrder WHEN "asc" THEN CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END WHEN "desc" THEN CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END END')
  // Future<List<Note>> getNotes(String sortOrder, String sortType);

  
  
//prouči
  // @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 ORDER BY CASE :sortOrder WHEN "asc" THEN CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END WHEN "desc" THEN CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END ELSE title END COLLATE NOCASE;')
  // Future<List<Note>> getNotes(String sortOrder, String sortType);

  
