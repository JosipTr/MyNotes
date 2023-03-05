import 'package:floor/floor.dart';

import '../../../../domain/entities/note.dart';
import '../../../models/note_model.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note')
  Future<List<NoteModel>> getAllNotes();

  @delete
  Future<void> removeNote(NoteModel note);

  @insert
  Future<void> insertNote(NoteModel note);

  @update
  Future<void> updateNote(NoteModel note);
}
