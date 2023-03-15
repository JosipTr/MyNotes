import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

var _sortType = '';

class GetNotes implements UseCase<List<Note>, Params> {
  final NoteRepository _noteRepository;

  const GetNotes(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call({Params? params}) async {
    final either = await _noteRepository.getSortType();
    either.fold((l) => 'Fail', (r) => _sortType = r!);

    if (params?.getNotesCriteria == GetNotesCriteria.deleted) {
      await _noteRepository.unselectAllNotes();
      return await _noteRepository.getDeletedNotes(_sortType);
    } else if (params?.getNotesCriteria == GetNotesCriteria.selectedDeleted) {
      return await _noteRepository.getDeletedNotes(_sortType);
    } else if (params?.getNotesCriteria == GetNotesCriteria.selected) {
      return await _noteRepository.getNotes(_sortType);
    } else if (params?.searchText != null &&
        params?.getNotesCriteria == GetNotesCriteria.searched) {
      return await _noteRepository.getSearchedNotes('${params!.searchText}%');
    } else if (params?.getNotesCriteria == GetNotesCriteria.favorite) {
      await _noteRepository.unselectAllNotes();
      return await _noteRepository.getFavoriteNotes(_sortType);
    } else if (params?.getNotesCriteria == GetNotesCriteria.selectedFavorite) {
      return await _noteRepository.getFavoriteNotes(_sortType);
    } else {
      await _noteRepository.unselectAllNotes();
      return await _noteRepository.getNotes(_sortType);
    }
  }
}
