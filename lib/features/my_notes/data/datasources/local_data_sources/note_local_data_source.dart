import 'package:flutter_notes/core/functions/get_sorted_notes.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/entities/sort.dart';
import 'database/database.dart';

bool _isSelectedDeleted = false;
bool _isSelected = false;
String _noteOrder = '';

abstract class NoteLocalDataSource {
  Future<List<Note>> getAllNotes(String? type, String? searchText);

  Future<void> removeNote();

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> updateNoteOrder(String noteOrder);

  Future<void> removeDeletedNotes();
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Note>> getAllNotes(String? type, String? searchText) async {
    if ((await _appDatabase.sortDao.getNoteOrder()) == null) {
      _appDatabase.sortDao.insertSort(const Sort(1, 'title'));
      _noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
    } else {
      _noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
    }
    if (type == 'select') {
      _isSelectedDeleted = false;
      _isSelected = false;
      return getSortedNotes(_noteOrder, _appDatabase);
    } else if (type == 'selectAllNormal') {
      _isSelected = !_isSelected;
      if (_isSelected == true) {
        _appDatabase.noteDao.selectAllNotes();
        return getSortedNotes(_noteOrder, _appDatabase);
      } else {
        _appDatabase.noteDao.updateSelectedNotes();
        return getSortedNotes(_noteOrder, _appDatabase);
      }
    } else if (type == 'selectAllDeleted') {
      _isSelectedDeleted = !_isSelectedDeleted;
      if (_isSelectedDeleted == true) {
        _appDatabase.noteDao.selectAllNotes();
        return _appDatabase.noteDao.getAllDeletedNotes();
      } else {
        _appDatabase.noteDao.updateSelectedNotes();
        return _appDatabase.noteDao.getAllDeletedNotes();
      }
    } else if (type == 'deleted') {
      _isSelectedDeleted = false;
      _isSelected = false;
      _appDatabase.noteDao.updateSelectedNotes();
      return _appDatabase.noteDao.getAllDeletedNotes();
    } else if (type == 'selectDeleted') {
      _isSelectedDeleted = false;
      _isSelected = false;
      return _appDatabase.noteDao.getAllDeletedNotes();
    } else if (type == 'search') {
      _isSelectedDeleted = false;
      _isSelected = false;
      return _appDatabase.noteDao.getSearchNote('$searchText%');
    } else {
      _isSelectedDeleted = false;
      _isSelected = false;
      _appDatabase.noteDao.updateSelectedNotes();
      return getSortedNotes(_noteOrder, _appDatabase);
    }
  }

  @override
  Future<void> insertNote(Note note) {
    return _appDatabase.noteDao.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) {
    return _appDatabase.noteDao.updateNote(note);
  }

  @override
  Future<void> removeNote() {
    return _appDatabase.noteDao.removeNote();
  }

  @override
  Future<void> updateNoteOrder(String noteOrder) {
    return _appDatabase.sortDao.updateNoteOrder(noteOrder);
  }

  @override
  Future<void> removeDeletedNotes() {
    return _appDatabase.noteDao.removeDeletedNotes();
  }
}
