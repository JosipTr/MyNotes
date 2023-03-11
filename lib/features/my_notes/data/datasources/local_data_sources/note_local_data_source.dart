import '../../../domain/entities/note.dart';
import '../../../domain/entities/sort.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> getAllNotes();

  Future<List<Note>> getAllSelectedNotes();

  Future<List<Note>> getSearchNote(String title);

  Future<void> removeNote();

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> updateNoteOrder(String noteOrder);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Note>> getAllNotes() async {
    String noteOrder;
    if ((await _appDatabase.sortDao.getNoteOrder()) == null) {
      _appDatabase.sortDao.insertSort(Sort(1, 'title'));
      noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
    } else {
      noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
      print('notInsert');
    }
    switch (noteOrder) {
      case 'date':
        {
          _appDatabase.noteDao.updateSelectedNotes();
          return _appDatabase.noteDao.getAllNotesByDate();
        }
      case 'title':
        {
          _appDatabase.noteDao.updateSelectedNotes();
          return _appDatabase.noteDao.getAllNotesByTitle();
        }
      case 'content':
        {
          _appDatabase.noteDao.updateSelectedNotes();
          return _appDatabase.noteDao.getAllNotesByContent();
        }
      default:
        {
          _appDatabase.noteDao.updateSelectedNotes();
          return _appDatabase.noteDao.getAllNotes();
        }
    }
  }

  @override
  Future<List<Note>> getAllSelectedNotes() async {
    var noteOrder = '';
    if ((await _appDatabase.sortDao.getNoteOrder()) == null) {
      _appDatabase.sortDao.insertSort(Sort(1, 'title'));
      noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
    } else {
      noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
    }
    switch (noteOrder) {
      case 'date':
        {
          return _appDatabase.noteDao.getAllNotesByDate();
        }
      case 'title':
        {
          return _appDatabase.noteDao.getAllNotesByTitle();
        }
      case 'content':
        {
          return _appDatabase.noteDao.getAllNotesByContent();
        }
      default:
        {
          return _appDatabase.noteDao.getAllNotes();
        }
    }
  }

  @override
  Future<List<Note>> getSearchNote(String title) {
    return _appDatabase.noteDao.getSearchNote('$title%');
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
}
