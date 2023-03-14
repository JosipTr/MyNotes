import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note.dart';

import '../../../../core/errors/failure.dart';
import '../entities/sort.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes(String? sortType);
  Future<Either<Failure, List<Note>>> getDeletedNotes(String? sortType);
  Future<Either<Failure, List<Note>>> getSearchedNotes(String? searchValue);
  Future<Either<Failure, void>> unselectAllNotes();
  Future<Either<Failure, void>> selectAllNotes();
  Future<Either<Failure, void>> selectNote(int? id);
  Future<Either<Failure, void>> setNoteDeleted();
  Future<Either<Failure, void>> setNoteUndeleted();
  Future<Either<Failure, void>> insertNote(Note? note);
  Future<Either<Failure, void>> removeNotes();
  Future<Either<Failure, void>> updateNoteContent(Note? note);

  Future<Either<Failure, void>> updateSortType(String? sortType);
  Future<Either<Failure, void>> insertSort(Sort? sort);
  Future<Either<Failure, String?>> getSortType();
}
