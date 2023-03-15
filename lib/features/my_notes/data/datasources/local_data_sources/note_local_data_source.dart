import '../../models/note_model.dart';
import '../../models/sort_model.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getNotes(String sortType);

  Future<List<NoteModel>> getDeletedNotes(String sortType);

  Future<List<NoteModel>> getSearchedNotes(String searchValue);

  Future<List<NoteModel>> getFavoriteNotes(String sortType);

  Future<void> selectAllNotes();

  Future<void> unselectAllNotes();

  Future<void> selectNote(int id);

  Future<void> setNoteDeleted();

  Future<void> setNoteUndeleted();

  Future<void> insertNote(NoteModel noteMode);

  Future<void> updateNoteContent(NoteModel noteModel);

  Future<void> removeNotes();

  Future<void> selectFavoriteNote(int id);

  //SortDao
  Future<String?> getSortType();

  Future<void> insertSort(SortModel sortModel);

  Future<void> updateSortType(String sortType);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<NoteModel>> getNotes(String sortType) async {
    final notes = await _appDatabase.noteDao.getNotes(sortType);
    return notes.map((note) => NoteModel.fromNote(note)).toList();
  }

  @override
  Future<List<NoteModel>> getDeletedNotes(String sortType) async {
    final notes = await _appDatabase.noteDao.getDeletedNotes(sortType);
    return notes.map((note) => NoteModel.fromNote(note)).toList();
  }

  @override
  Future<List<NoteModel>> getSearchedNotes(String searchValue) async {
    final notes = await _appDatabase.noteDao.getSearchedNotes(searchValue);
    return notes.map((note) => NoteModel.fromNote(note)).toList();
  }

  @override
  Future<List<NoteModel>> getFavoriteNotes(String sortType) async {
    final notes = await _appDatabase.noteDao.getFavoriteNotes(sortType);
    return notes.map((note) => NoteModel.fromNote(note)).toList();
  }

  @override
  Future<void> insertNote(NoteModel noteModel) {
    return _appDatabase.noteDao.insertNote(noteModel);
  }

  @override
  Future<void> updateNoteContent(NoteModel noteModel) {
    return _appDatabase.noteDao.updateNoteContent(noteModel);
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
  Future<String?> getSortType() async {
    if (await _appDatabase.sortDao.getSortType() != null) {
      return _appDatabase.sortDao.getSortType();
    } else {
      insertSort(SortModel(id: 1, sortType: 'title'));
      return _appDatabase.sortDao.getSortType();
    }
  }

  @override
  Future<void> insertSort(SortModel sortModel) {
    return _appDatabase.sortDao.insertSort(sortModel);
  }

  @override
  Future<void> selectFavoriteNote(int id) {
    return _appDatabase.noteDao.selectFavoriteNote(id);
  }
}
