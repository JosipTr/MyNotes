import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';

@dao
abstract class NoteDao {
  @Query(
      'SELECT * FROM Note WHERE isDeleted=0 ORDER BY (CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END)')
  Future<List<Note>> getNotes(String sortType);

  @Query(
      'SELECT * FROM Note WHERE isDeleted=1 ORDER BY (CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END)')
  Future<List<Note>> getDeletedNotes(String sortType);

  @Query(
      'SELECT * FROM Note WHERE isDeleted=0 AND (title LIKE :searchValue OR content LIKE :searchValue)')
  Future<List<Note>> getSearchedNotes(String searchValue);

  @Query(
      'SELECT * FROM Note WHERE isFavorite=1 AND isDeleted=0 ORDER BY (CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END)')
  Future<List<Note>> getFavoriteNotes(String sortType);

  @Query('UPDATE Note SET isSelected=0')
  Future<void> unselectAllNotes();

  @Query(
      'UPDATE Note SET isSelected=CASE WHEN isSelected=1 THEN 0 ELSE 1 END WHERE isDeleted=0')
  Future<void> selectAllNotes();

  @Query(
      'UPDATE Note SET isSelected=CASE WHEN isSelected=1 THEN 0 ELSE 1 END WHERE id=:id')
  Future<void> selectNote(int id);

  @Query(
      'UPDATE Note SET isFavorite=CASE WHEN isFavorite=1 THEN 0 ELSE 1 END WHERE id=:id')
  Future<void> selectFavoriteNote(int id);

  @Query('UPDATE Note SET isDeleted=1 WHERE isSelected=1')
  Future<void> setNoteDeleted();

  @Query('UPDATE Note SET isDeleted=0 WHERE isSelected=1')
  Future<void> setNoteUndeleted();

  @Query('DELETE FROM Note WHERE isDeleted=1')
  Future<void> removeNotes();

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNoteContent(Note note);
}

//Works for DESC
// @Query(
//       'SELECT * FROM Note WHERE isDeleted=0 ORDER BY (CASE :sortType WHEN "title" THEN title WHEN "date" THEN date ELSE title END) DESC')
//   Future<List<Note>> getNotes(String sortType);


  // @Query(
  //     'SELECT * FROM Note WHERE isDeleted=0 ORDER BY (CASE :sortType WHEN "title" TdHEN title WHEN "date" THEN date ELSE title END)')
  // Future<List<Note>> getNotes(String sortType);
