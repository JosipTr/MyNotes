import 'dart:async';

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

  NoteRepositoryImpl(this._noteLocalDataSource);

  @override
  Future<Either<Failure, Stream<List<Note>>>> getNotes() async {
    try {
      final noteModelStream = _noteLocalDataSource.getNotes();
      final noteStream = noteModelStream.map((List<NoteModel> noteModels) =>
          noteModels.map((noteModel) => noteModel.toNote()).toList());
      return Right(noteStream);
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
  Future<Either<Failure, Success>> updateSort(String sortType) async {
    try {
      await _noteLocalDataSource.updateSort(sortType);
      return const Right(Success());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }
}
