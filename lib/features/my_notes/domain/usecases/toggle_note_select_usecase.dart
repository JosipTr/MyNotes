import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/success.dart';
import '../../../../core/usecases/usecase.dart';

class ToggleNoteSelectUseCase
    implements UseCase<Success, ToggleNoteSelectParams> {
  final NoteRepository _noteRepository;
  const ToggleNoteSelectUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(ToggleNoteSelectParams params) async {
    final newNote = params.note.copyWith(isSelected: !params.note.isSelected);
    await _noteRepository.updateNote(newNote);
    return const Right(Success());
  }
}
