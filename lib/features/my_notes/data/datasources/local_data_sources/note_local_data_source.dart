import 'dart:developer';

import '../../../../../core/errors/exception.dart';

import '../../models/note_model.dart';
import '../../models/sort_model.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Stream<List<NoteModel>> getNotes();

  Future<void> insertNote(NoteModel noteModel);

  Future<void> updateNote(NoteModel noteModel);

  Future<void> removeNote(NoteModel noteModel);

  //SortDao
  Future<String?> getSortType();

  Future<void> insertSort(SortModel sortModel);

  Future<void> updateSort(String sortType);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Stream<List<NoteModel>> getNotes() {
    try {
      final notes = _appDatabase.noteDao.getNotes();
      return notes;
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }

  @override
  Future<void> insertNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.insertNote(noteModel);
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.updateNote(noteModel);
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }

  @override
  Future<void> removeNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.removeNote(noteModel);
    } catch (error) {
      log(error.toString());
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
        insertSort(const SortModel(id: 1, sortType: 'title'));
        return await _appDatabase.sortDao.getSortType();
      }
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }

  @override
  Future<void> insertSort(SortModel sortModel) async {
    try {
      return await _appDatabase.sortDao.insertSort(sortModel);
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }

  @override
  Future<void> updateSort(String sortType) async {
    try {
      return await _appDatabase.sortDao.updateSort(sortType);
    } catch (error) {
      log(error.toString());
      throw const DatabaseException();
    }
  }
}
