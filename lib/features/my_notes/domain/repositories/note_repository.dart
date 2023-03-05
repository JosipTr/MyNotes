import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note.dart';

import '../../../../core/errors/failure.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, void>> insertNote(Note note);
  Future<Either<Failure, void>> removeNote(Note note);
  Future<Either<Failure, void>> updateNote(Note note);
}
