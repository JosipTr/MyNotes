import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../entities/note.dart';
import '../entities/sort.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Success>> insertNote(Note note);
  Future<Either<Failure, Success>> removeNote(Note note);
  Future<Either<Failure, Success>> updateNote(Note note);

  //Sort
  Future<Either<Failure, Success>> updateSort(Sort sort);
  Future<Either<Failure, Success>> insertSort(Sort sort);
  Future<Either<Failure, String?>> getSortType();
}
