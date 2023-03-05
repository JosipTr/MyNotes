import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/note.dart';

class InsertNote {
  final NoteRepository _repository;

  const InsertNote(this._repository);

  Future<Either<Failure, void>> insertNote(Note note) async {
    return await _repository.insertNote(note);
  }
}
