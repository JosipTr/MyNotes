import 'package:flutter_notes/core/errors/exception.dart';

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
    try {
      final notes = await _appDatabase.noteDao.getNotes(sortType);
      return notes.map((note) => NoteModel.fromNote(note)).toList();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<NoteModel>> getDeletedNotes(String sortType) async {
    try {
      final notes = await _appDatabase.noteDao.getDeletedNotes(sortType);
      return notes.map((note) => NoteModel.fromNote(note)).toList();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<NoteModel>> getSearchedNotes(String searchValue) async {
    try {
      final notes = await _appDatabase.noteDao.getSearchedNotes(searchValue);
      return notes.map((note) => NoteModel.fromNote(note)).toList();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<NoteModel>> getFavoriteNotes(String sortType) async {
    try {
      final notes = await _appDatabase.noteDao.getFavoriteNotes(sortType);
      return notes.map((note) => NoteModel.fromNote(note)).toList();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> insertNote(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.insertNote(noteModel);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> updateNoteContent(NoteModel noteModel) async {
    try {
      return await _appDatabase.noteDao.updateNoteContent(noteModel);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> updateSortType(String sortType) async {
    try {
      return await _appDatabase.sortDao.updateSortType(sortType);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> removeNotes() async {
    try {
      return await _appDatabase.noteDao.removeNotes();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> selectAllNotes() async {
    try {
      return await _appDatabase.noteDao.selectAllNotes();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> selectNote(int id) async {
    try {
      return await _appDatabase.noteDao.selectNote(id);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> setNoteDeleted() async {
    try {
      return await _appDatabase.noteDao.setNoteDeleted();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> setNoteUndeleted() async {
    try {
      return await _appDatabase.noteDao.setNoteUndeleted();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> unselectAllNotes() async {
    try {
      return await _appDatabase.noteDao.unselectAllNotes();
    } catch (e) {
      throw DatabaseException();
    }
  }

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
      throw DatabaseException();
    }
  }

  @override
  Future<void> insertSort(SortModel sortModel) async {
    try {
      return await _appDatabase.sortDao.insertSort(sortModel);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> selectFavoriteNote(int id) async {
    try {
      return await _appDatabase.noteDao.selectFavoriteNote(id);
    } catch (e) {
      throw DatabaseException();
    }
  }
}
