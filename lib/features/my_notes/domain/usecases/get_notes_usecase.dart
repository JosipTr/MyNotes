import 'package:dartz/dartz.dart';

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
    return either.fold((failure) => Left(failure), (notes) {
      if (_sortType == "title") {
        notes.sort((a, b) => a.title.compareTo(b.title));
      } else if (_sortType == "date") {
        notes.sort((a, b) => a.date.compareTo(b.date));
      } else if (_sortType == "titleDesc") {
        notes.sort((a, b) => b.title.compareTo(a.title));
      } else if (_sortType == "dateDesc") {
        notes.sort((a, b) => b.date.compareTo(a.date));
      } else {
        notes.sort((a, b) => a.title.compareTo(b.title));
      }
      final sortedNoteList =
          notes.where((note) => note.isDeleted == false).map((note) {
        note.isSelected = false;
        _noteRepository.updateNote(note);
        return note;
      }).toList();
      return Right(sortedNoteList);
    });
  }
}
