import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/success.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class UnselectAllNotes extends UseCase<Success, UnselectAllParams> {
  final NoteRepository _noteRepository;

  UnselectAllNotes(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(UnselectAllParams params) async {
    for (final note in params.notes) {
      if (note.isSelected == true) {
        final newNote = note.copyWith(isSelected: false);
        await _noteRepository.updateNote(newNote);
      }
    }
    return const Right(Success());
  }
}
