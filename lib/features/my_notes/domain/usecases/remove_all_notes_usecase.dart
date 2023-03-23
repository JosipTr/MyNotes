import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/success.dart';

class RemoveAllNotesUseCase implements UseCase<Success, RemoveAllNotesParams> {
  final NoteRepository _noteRepository;

  const RemoveAllNotesUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(RemoveAllNotesParams params) async {
    for (var note in params.notes) {
      if (note.isDeleted == true) {
        await _noteRepository.removeNote(note);
      }
    }
    params.notes.removeWhere((note) => note.isDeleted == true);
    return const Right(Success());
  }
}
