import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/note.dart';

class GetAllNotes {
  final NoteRepository _repository;

  const GetAllNotes(this._repository);

  Future<Either<Failure, List<Note>>> getAllNotes() async {
    return await _repository.getAllNotes();
  }
}
