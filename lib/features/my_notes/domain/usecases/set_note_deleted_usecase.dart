import '../../../../core/errors/failure.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/success.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/note_repository.dart';

class SetNoteDeletedUseCase implements UseCase<Success, SetNoteDeletedParams> {
  final NoteRepository _noteRepository;

  const SetNoteDeletedUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(SetNoteDeletedParams params) async {
    for (var note in params.notes) {
      if (note.isSelected == true) {
        note.isDeleted = true;
        note.isSelected = false;
        await _noteRepository.updateNote(note);
      }
    }
    return const Right(Success());
  }
}
