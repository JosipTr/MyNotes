import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/note.dart';

class RemoveNote {
  final NoteRepository _repository;

  const RemoveNote(this._repository);

  Future<Either<Failure, void>> removeNote(Note note) async {
    return await _repository.removeNote(note);
  }
}
