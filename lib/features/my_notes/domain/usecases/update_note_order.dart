import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class UpdateNoteOrder implements UseCase<void, Params> {
  final NoteRepository _noteRepository;

  const UpdateNoteOrder(this._noteRepository);

  @override
  Future<Either<Failure, void>> call({Params? params}) async {
    return await _noteRepository.updateNoteOrder(params!.noteOrder);
  }
}
