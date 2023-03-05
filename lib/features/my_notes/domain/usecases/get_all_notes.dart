import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetAllNotes implements UseCase<List<Note>, NoParams> {
  final NoteRepository _repository;

  const GetAllNotes(this._repository);

  @override
  Future<Either<Failure, List<Note>>> call({NoParams? noParams}) async {
    return await _repository.getAllNotes();
  }
}
