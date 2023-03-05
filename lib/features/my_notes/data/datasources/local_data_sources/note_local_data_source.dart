import '../../../domain/entities/note.dart';
import 'database/database.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> getAllNotes();

  Future<void> removeNote(Note note);

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Note>> getAllNotes() {
    return _appDatabase.noteDao.getAllNotes();
  }

  @override
  Future<void> insertNote(Note note) {
    return _appDatabase.noteDao.insertNote(note);
  }

  @override
  Future<void> removeNote(Note note) {
    return _appDatabase.noteDao.removeNote(note);
  }

  @override
  Future<void> updateNote(Note note) {
    return _appDatabase.noteDao.updateNote(note);
  }
}
