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
  Future<Either<Failure, void>> insertNote(Note note) async {
    try {
      return Right(await _noteLocalDataSource.insertNote(note));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeNote(Note note) async {
    try {
      return Right(_noteLocalDataSource.removeNote(note));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(Note note) async {
    try {
      return Right(await _noteLocalDataSource.updateNote(note));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}