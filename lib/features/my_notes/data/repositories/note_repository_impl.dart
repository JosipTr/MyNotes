import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/sort.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local_data_sources/note_local_data_source.dart';
import '../models/note_model.dart';
import '../models/sort_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _noteLocalDataSource;

  const NoteRepositoryImpl(this._noteLocalDataSource);

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final notes = await _noteLocalDataSource.getNotes();
      return Right(notes);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> insertNote(Note note) async {
    try {
      final noteModel = NoteModel.fromNote(note);
      await _noteLocalDataSource.insertNote(noteModel);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> removeNote(Note note) async {
    try {
      final noteModel = NoteModel.fromNote(note);
      await _noteLocalDataSource.removeNote(noteModel);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> updateNote(Note note) async {
    try {
      final noteModel = NoteModel.fromNote(note);
      await _noteLocalDataSource.updateNote(noteModel);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

//Sort

  @override
  Future<Either<Failure, String?>> getSortType() async {
    try {
      final sortType = await _noteLocalDataSource.getSortType();
      return Right(sortType);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> insertSort(Sort sort) async {
    try {
      final sortModel = SortModel.fromSort(sort);
      await _noteLocalDataSource.insertSort(sortModel);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> updateSort(Sort sort) async {
    try {
      final sortModel = SortModel.fromSort(sort);
      await _noteLocalDataSource.updateSort(sortModel);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }
}
