import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/note_repository.dart';

class RemoveDeletedNotes implements UseCase<void, NoParams> {
  final NoteRepository _repository;

  const RemoveDeletedNotes(this._repository);

  @override
  Future<Either<Failure, void>> call({NoParams? noParams}) async {
    return await _repository.removeDeletedNotes();
  }
}
