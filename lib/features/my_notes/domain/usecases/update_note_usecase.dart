import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/success.dart';
import '../../../../core/functions/get_datetime.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUseCase implements UseCase<Success, UpdateNoteParams> {
  final NoteRepository _noteRepository;
  const UpdateNoteUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(UpdateNoteParams params) async {
    params.note.title = params.title;
    params.note.description = params.description;
    params.note.date = getDateTime();
    return await _noteRepository.updateNote(params.note);
  }
}
