import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/success.dart';

class SetAllNotesUnselectedUseCase
    implements UseCase<Success, SetAllNotesUnselectedParams> {
  final NoteRepository _noteRepository;

  const SetAllNotesUnselectedUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(
      SetAllNotesUnselectedParams params) async {
    for (var note in params.notes) {
      note.isSelected = false;
      await _noteRepository.updateNote(note);
    }
    return const Right(Success());
  }
}
