import 'package:dartz/dartz.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

var _sortType = '';

class GetNotesUseCase implements UseCase<List<Note>, NoParams> {
  final NoteRepository _noteRepository;

  const GetNotesUseCase(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    final sortEither = await _noteRepository.getSortType();
    sortEither.fold((l) => l, (r) => _sortType = r!);
    final either = await _noteRepository.getNotes();
    return either.fold(
      (failure) => Left(failure),
      (notes) => Right(_getNotes(notes)),
    );
  }

  List<Note> _getNotes(List<Note> notes) {
    return notes.where((note) => note.isDeleted == false).toList()
      ..sort((a, b) {
        switch (_sortType) {
          case StringConstants.titleSortType:
            return a.title.compareTo(b.title);
          case StringConstants.dateSortType:
            return a.date.compareTo(b.date);
          case StringConstants.titleDescSortType:
            return b.title.compareTo(a.title);
          case StringConstants.dateDescSortType:
            return b.date.compareTo(a.date);
          default:
            return a.title.compareTo(b.title);
        }
      });
  }
}
