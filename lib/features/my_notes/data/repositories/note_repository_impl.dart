import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local_data_sources/note_local_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _noteLocalDataSource;

  const NoteRepositoryImpl(this._noteLocalDataSource);

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final noteList = await _noteLocalDataSource.getAllNotes();
      return Right(noteList);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getAllSelectedNotes() async {
    try {
      final noteList = await _noteLocalDataSource.getAllSelectedNotes();
      return Right(noteList);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getSearchNote(String? title) async {
    try {
      final noteList = await _noteLocalDataSource.getSearchNote(title!);
      return Right(noteList);
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
  Future<Either<Failure, void>> removeNote() async {
    try {
      return Right(_noteLocalDataSource.removeNote());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(Note? note) async {
    try {
      return Right(await _noteLocalDataSource.updateNote(note!));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNoteOrder(String? noteOrder) async {
    try {
      return Right(await _noteLocalDataSource.updateNoteOrder(noteOrder!));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
