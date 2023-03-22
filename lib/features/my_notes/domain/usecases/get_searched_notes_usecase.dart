import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetSearchedNotes implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetSearchedNotes(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    final either = await _noteRepository.getNotes();
    return either.fold((failure) {
      return Left(failure);
    }, (notes) {
      final favoriteNotes = List<Note>.empty(growable: true);
      return Right(favoriteNotes);
    });
  }
}

// return await _noteRepository.getSearchedNotes('${params!.searchText}%');