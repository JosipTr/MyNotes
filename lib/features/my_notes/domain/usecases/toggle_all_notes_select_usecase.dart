import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/success.dart';

class ToggleAllNotesSelectUseCase
    implements UseCase<Success, ToggleAllNotesSelectParams> {
  final NoteRepository _noteRepository;
  const ToggleAllNotesSelectUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(
      ToggleAllNotesSelectParams params) async {
    for (final note in params.notes) {
      final newNote = note.copyWith(isSelected: true);
      await _noteRepository.updateNote(newNote);
    }
    return const Right(Success());
  }
}
