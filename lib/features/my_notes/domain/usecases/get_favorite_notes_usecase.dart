import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetFavoriteNotesUsecase implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetFavoriteNotesUsecase(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    final either = await _noteRepository.getNotes();
    return either.fold((failure) => Left(failure), (notes) {
      final noteList =
          notes.where((note) => note.isFavorite).map((note) => note).toList();
      return Right(noteList);
    });
  }
}
