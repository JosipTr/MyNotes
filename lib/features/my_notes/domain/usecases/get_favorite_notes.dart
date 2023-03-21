import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetFavoriteNotes implements UseCase<List<Note>, Params> {
  final NoteRepository _noteRepository;

  const GetFavoriteNotes(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call({Params? params}) async {
    return await _noteRepository.getFavoriteNotes(params!.sortType);
  }
}
