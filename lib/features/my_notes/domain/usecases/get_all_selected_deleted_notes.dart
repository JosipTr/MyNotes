import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../entities/note.dart';

class GetAllSelectedDeletedNotes implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetAllSelectedDeletedNotes(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call({NoParams? noParams}) async {
    return await _noteRepository.getAllSelectedDeletedNotes();
  }
}
