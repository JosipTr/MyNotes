import 'package:flutter_notes/core/enums/update_notes_criteria.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class UpdateNotes implements UseCase<void, Params> {
  final NoteRepository _noteRepository;
  const UpdateNotes(this._noteRepository);

  @override
  Future<Either<Failure, void>> call({Params? params}) async {
    if (params!.updateNotesCriteria != null) {
      if (params.updateNotesCriteria == UpdateNotesCriteria.undelete) {
        return await _noteRepository.setNoteUndeleted();
      } else if (params.updateNotesCriteria ==
          UpdateNotesCriteria.unselectAll) {
        return await _noteRepository.unselectAllNotes();
      } else if (params.updateNotesCriteria == UpdateNotesCriteria.select) {
        return await _noteRepository.selectNote(params.id);
      } else if (params.updateNotesCriteria == UpdateNotesCriteria.delete) {
        return await _noteRepository.setNoteDeleted();
      } else if (params.updateNotesCriteria == UpdateNotesCriteria.sortType) {
        return await _noteRepository.updateSortType(params.sortType);
      } else if (params.updateNotesCriteria == UpdateNotesCriteria.favorite) {
        return await _noteRepository.selectFavoriteNote(params.id);
      } else {
        return await _noteRepository.selectAllNotes();
      }
    } else {
      return await _noteRepository.updateNoteContent(params.note);
    }
  }
}
