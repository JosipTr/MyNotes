import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetSearchNote implements UseCase<List<Note>, Params> {
  final NoteRepository _repository;

  const GetSearchNote(this._repository);

  @override
  Future<Either<Failure, List<Note>>> call({Params? params}) async {
    return await _repository.getSearchNote(params!.searchText);
  }
}
