import '../../../domain/entities/note.dart';
import '../../../domain/entities/sort.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> getNotes(String sortType);

  Future<List<Note>> getDeletedNotes(String sortType);

  Future<List<Note>> getSearchedNotes(String searchValue);

  Future<void> selectAllNotes();

  Future<void> unselectAllNotes();

  Future<void> selectNote(int id);

  Future<void> setNoteDeleted();

  Future<void> setNoteUndeleted();

  Future<void> insertNote(Note note);

  Future<void> updateNoteContent(Note note);

  Future<void> removeNotes();

  //SortDao
  Future<String?> getSortType();

  Future<void> insertSort(Sort sort);

  Future<void> updateSortType(String sortType);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Note>> getNotes(String sortType) {
    return _appDatabase.noteDao.getNotes(sortType);
  }

  @override
  Future<List<Note>> getDeletedNotes(String sortType) {
    return _appDatabase.noteDao.getDeletedNotes(sortType);
  }

  @override
  Future<List<Note>> getSearchedNotes(String searchValue) {
    return _appDatabase.noteDao.getSearchedNotes(searchValue);
  }

  @override
  Future<void> insertNote(Note note) {
    return _appDatabase.noteDao.insertNote(note);
  }

  @override
  Future<void> updateNoteContent(Note note) {
    return _appDatabase.noteDao.updateNoteContent(note);
  }

  @override
  Future<void> updateSortType(String sortType) {
    return _appDatabase.sortDao.updateSortType(sortType);
  }

  @override
  Future<void> removeNotes() {
    return _appDatabase.noteDao.removeNotes();
  }

  @override
  Future<void> selectAllNotes() {
    return _appDatabase.noteDao.selectAllNotes();
  }

  @override
  Future<void> selectNote(int id) {
    return _appDatabase.noteDao.selectNote(id);
  }

  @override
  Future<void> setNoteDeleted() {
    return _appDatabase.noteDao.setNoteDeleted();
  }

  @override
  Future<void> setNoteUndeleted() {
    return _appDatabase.noteDao.setNoteUndeleted();
  }

  @override
  Future<void> unselectAllNotes() {
    return _appDatabase.noteDao.unselectAllNotes();
  }

  @override
  Future<String?> getSortType() {
    return _appDatabase.sortDao.getSortType();
  }

  @override
  Future<void> insertSort(Sort sort) {
    return _appDatabase.sortDao.insertSort(sort);
  }
}
