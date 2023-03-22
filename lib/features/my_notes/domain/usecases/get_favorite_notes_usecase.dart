import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

var _sortType = '';

class GetFavoriteNotesUsecase implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetFavoriteNotesUsecase(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    final sortEither = await _noteRepository.getSortType();
    sortEither.fold((l) => l, (r) => _sortType = r!);
    final either = await _noteRepository.getNotes();
    return either.fold(
      (failure) => Left(failure),
      (notes) => Right(_getFavoriteNotes(notes)),
    );
  }

  List<Note> _getFavoriteNotes(List<Note> notes) {
    return notes
        .where((note) => note.isDeleted == false && note.isFavorite == true)
        .toList()
      ..sort((a, b) {
        switch (_sortType) {
          case "title":
            return a.title.compareTo(b.title);
          case "date":
            return a.date.compareTo(b.date);
          case "titleDesc":
            return b.title.compareTo(a.title);
          case "dateDesc":
            return b.date.compareTo(a.date);
          default:
            return a.title.compareTo(b.title);
        }
      });
  }
}
