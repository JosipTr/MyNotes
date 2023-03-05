import 'package:flutter_notes/features/my_notes/data/datasources/local_data_sources/database/database.dart';

import '../../../domain/entities/note.dart';
import '../../models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getAllNotes();

  Future<void> removeNote(NoteModel note);

  Future<void> insertNote(NoteModel note);

  Future<void> updateNote(NoteModel note);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase _appDatabase;

  const NoteLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<NoteModel>> getAllNotes() {
    return _appDatabase.noteDao.getAllNotes();
  }

  @override
  Future<void> insertNote(NoteModel note) {
    return _appDatabase.noteDao.insertNote(note);
  }

  @override
  Future<void> removeNote(NoteModel note) {
    return _appDatabase.noteDao.removeNote(note);
  }

  @override
  Future<void> updateNote(NoteModel note) {
    return _appDatabase.noteDao.updateNote(note);
  }
}
