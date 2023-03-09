import '../../../domain/entities/note.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> getAllNotes();

  Future<List<Note>> getAllSelectedNotes();

  Future<void> removeNote();

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Note>> getAllNotes() {
    _appDatabase.noteDao.updateSelectedNotes();
    return _appDatabase.noteDao.getAllNotes();
  }

  @override
  Future<List<Note>> getAllSelectedNotes() {
    return _appDatabase.noteDao.getAllNotes();
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
}
