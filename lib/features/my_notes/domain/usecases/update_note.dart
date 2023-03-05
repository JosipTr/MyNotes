import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/failure.dart';

class UpdateNote {
  final NoteRepository _repository;

  const UpdateNote(this._repository);

  Future<Either<Failure, void>> updateNote() async {
    return await _repository.updateNote();
  }
}
