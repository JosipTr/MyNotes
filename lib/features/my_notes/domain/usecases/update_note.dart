import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UpdateNote implements UseCase<void, Note> {
  final NoteRepository _repository;

  const UpdateNote(this._repository);

  @override
  Future<Either<Failure, void>> call({Params? params}) async {
    return await _repository.updateNote(params!.note);
  }
}
