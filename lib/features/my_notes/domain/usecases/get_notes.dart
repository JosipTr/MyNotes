import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../entities/sort.dart';
import '../repositories/note_repository.dart';

var _sortType = 'title';

class GetNotes implements UseCase<List<Note>, Params> {
  final NoteRepository _noteRepository;

  const GetNotes(this._noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call({Params? params}) async {
    // final either = await _noteRepository.getSortType();
    // either.fold((failure) => 'Fail', (sortType) => _sortType = sortType);

    // if (_sortType == null) {
    //   await _noteRepository.insertSort(const Sort(1, 'date'));
    //   either.fold((l) => {}, (r) => _sortType = r);
    // } else {
    //   either.fold((l) => {}, (r) => _sortType = r);
    // }
    // print(_sortType);

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
    } else {
      await _noteRepository.unselectAllNotes();
      return await _noteRepository.getNotes(_sortType);
    }
  }
}
// if ((await _appDatabase.sortDao.getNoteOrder()) == null) {
//       _appDatabase.sortDao.insertSort(const Sort(1, 'title'));
//       _noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
//     } else {
//       _noteOrder = (await _appDatabase.sortDao.getNoteOrder())!;
//     }


