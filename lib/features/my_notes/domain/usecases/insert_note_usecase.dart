import 'package:dartz/dartz.dart';
import '../../../../core/errors/success.dart';
import '../../../../core/functions/get_datetime.dart';
import '../entities/note.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/note_repository.dart';

class InsertNoteUseCase implements UseCase<Success, InsertNoteParams> {
  final NoteRepository _noteRepository;

  const InsertNoteUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(InsertNoteParams params) async {
    if (params.title.isEmpty && params.description.isEmpty) {
      final failure = InputFailure("Note is not added!");
      return Left(failure);
    } else {
      final date = getDateTime();
      final note = Note(
          title: params.title, description: params.description, date: date);
      return await _noteRepository.insertNote(note);
    }
  }
}
