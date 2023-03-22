import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetDeletedNotesUseCase implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetDeletedNotesUseCase(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    final either = await _noteRepository.getNotes();
    return either.fold((failure) => Left(failure), (notes) {
      final noteList =
          notes.where((note) => note.isDeleted).map((note) => note).toList();
      return Right(noteList);
    });
  }
}
