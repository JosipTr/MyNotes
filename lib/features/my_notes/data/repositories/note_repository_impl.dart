import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/sort.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local_data_sources/note_local_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _noteLocalDataSource;

  const NoteRepositoryImpl(this._noteLocalDataSource);

  @override
  Future<Either<Failure, List<Note>>> getNotes(String? sortType) async {
    try {
      final notes = await _noteLocalDataSource.getNotes(sortType!);
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertNote(Note? note) async {
    try {
      return Right(await _noteLocalDataSource.insertNote(note!));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeNotes() async {
    try {
      return Right(_noteLocalDataSource.removeNotes());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getDeletedNotes(String? sortType) async {
    try {
      final notes = await _noteLocalDataSource.getDeletedNotes(sortType!);
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> selectAllNotes() async {
    try {
      final notes = await _noteLocalDataSource.selectAllNotes();
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> selectNote(int? id) async {
    try {
      final notes = await _noteLocalDataSource.selectNote(id!);
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setNoteDeleted() async {
    try {
      final notes = await _noteLocalDataSource.setNoteDeleted();
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setNoteUndeleted() async {
    try {
      final notes = await _noteLocalDataSource.setNoteUndeleted();
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unselectAllNotes() async {
    try {
      final notes = await _noteLocalDataSource.unselectAllNotes();
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getSearchedNotes(
      String? searchValue) async {
    try {
      final notes = await _noteLocalDataSource.getSearchedNotes(searchValue!);
      return Right(notes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getSortType() async {
    try {
      final sortType = await _noteLocalDataSource.getSortType();
      return Right(sortType);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertSort(Sort? sort) async {
    try {
      final insert = await _noteLocalDataSource.insertSort(sort!);
      return Right(insert);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateSortType(String? sortType) async {
    try {
      final updateSortType =
          await _noteLocalDataSource.updateSortType(sortType!);
      return Right(updateSortType);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNoteContent(Note? note) async {
    try {
      final updateNoteContent =
          await _noteLocalDataSource.updateNoteContent(note!);
      return Right(updateNoteContent);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
