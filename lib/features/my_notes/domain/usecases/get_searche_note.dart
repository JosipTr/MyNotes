import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetSearchNote {
  final NoteRepository _repository;

  const GetSearchNote(this._repository);

  Future<Either<Failure, List<Note>>> call(String title) async {
    return await _repository.getSearchNote(title);
  }
}
