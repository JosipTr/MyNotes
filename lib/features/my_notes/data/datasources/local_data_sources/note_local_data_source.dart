import '../../../../../core/errors/exception.dart';

import '../../models/note_model.dart';
import '../../models/sort_model.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getNotes();

  Future<void> insertNote(NoteModel noteModel);

  Future<void> updateNote(NoteModel noteModel);

  Future<void> removeNote(NoteModel noteModel);

  //SortDao
  Future<String?> getSortType();

  Future<void> insertSort(SortModel sortModel);

  Future<void> updateSort(SortModel sortModel);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      final notes = await _appDatabase.noteDao.getNotes();
      return notes.map((note) => NoteModel.fromNote(note)).toList();
    } catch (e) {
      throw const DatabaseException();
    }
  }

  @override
  Future<void> insertNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.insertNote(noteModel);
    } catch (e) {
      throw const DatabaseException();
    }
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.updateNote(noteModel);
    } catch (e) {
      throw const DatabaseException();
    }
  }

  @override
  Future<void> removeNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.removeNote(noteModel);
    } catch (e) {
      throw const DatabaseException();
    }
  }

  //Sort

  @override
  Future<String?> getSortType() async {
    try {
      if (await _appDatabase.sortDao.getSortType() != null) {
        return _appDatabase.sortDao.getSortType();
      } else {
        insertSort(SortModel(id: 1, sortType: 'title'));
        return await _appDatabase.sortDao.getSortType();
      }
    } catch (e) {
      throw const DatabaseException();
    }
  }

  @override
  Future<void> insertSort(SortModel sortModel) async {
    try {
      return await _appDatabase.sortDao.insertSort(sortModel);
    } catch (e) {
      throw const DatabaseException();
    }
  }

  @override
  Future<void> updateSort(SortModel sortModel) async {
    try {
      return await _appDatabase.sortDao.updateSort(sortModel);
    } catch (e) {
      throw const DatabaseException();
    }
  }
}
