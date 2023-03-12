import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetAllNotes implements UseCase<List<Note>, Params> {
  final NoteRepository _repository;

  const GetAllNotes(this._repository);

  @override
  Future<Either<Failure, List<Note>>> call({Params? params}) async {
    return await _repository.getAllNotes(params!.type, params.searchText);
  }
}
