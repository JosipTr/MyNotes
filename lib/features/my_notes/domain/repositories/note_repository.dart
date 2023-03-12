import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note.dart';

import '../../../../core/errors/failure.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getAllNotes(
      String? type, String? searchText);
  Future<Either<Failure, void>> insertNote(Note? note);
  Future<Either<Failure, void>> removeNote();
  Future<Either<Failure, void>> updateNote(Note? note);
  Future<Either<Failure, void>> updateNoteOrder(String? note);
  Future<Either<Failure, void>> removeDeletedNotes();
}
