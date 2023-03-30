import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/success.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class ToggleNoteFavoriteUsecase
    extends UseCase<Success, ToggleNoteFavoriteParams> {
  final NoteRepository _noteRepository;

  ToggleNoteFavoriteUsecase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(ToggleNoteFavoriteParams params) async {
    final newNote = params.note.copyWith(isFavorite: !params.note.isFavorite);
    await _noteRepository.updateNote(newNote);
    return const Right(Success());
  }
}
