import 'package:flutter_notes/features/my_notes/data/datasources/local_data_sources/database/database.dart';

import '../../features/my_notes/domain/entities/note.dart';

Future<List<Note>> getSortedNotes(String noteOrder, AppDatabase appDatabase) {
  switch (noteOrder) {
    case 'date':
      {
        return appDatabase.noteDao.getAllNotesByDate();
      }
    case 'title':
      {
        return appDatabase.noteDao.getAllNotesByTitle();
      }
    case 'dateDesc':
      {
        return appDatabase.noteDao.getAllNotesByDateDesc();
      }
    case 'titleDesc':
      {
        return appDatabase.noteDao.getAllNotesByTitleDesc();
      }
    default:
      {
        return appDatabase.noteDao.getAllNotes();
      }
  }
}
