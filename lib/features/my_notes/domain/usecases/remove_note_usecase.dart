import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/note_repository.dart';

class RemoveNoteUseCase implements UseCase<Success, RemoveNoteParams> {
  final NoteRepository _noteRepository;

  const RemoveNoteUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(RemoveNoteParams params) async {
    for (var note in params.notes) {
      if (note.isSelected == true && note.isDeleted == true) {
        await _noteRepository.removeNote(note);
      }
    }
    return const Right(Success());
  }
}
