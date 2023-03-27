import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/success.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/sort.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class InsertSortUseCase implements UseCase<Success, NoParams> {
  final NoteRepository _noteRepository;

  const InsertSortUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    final sort = Sort(id: 1, sortType: 'title');
    try {
      return await _noteRepository.insertSort(sort);
    } catch (e) {
      final failure = DatabaseFailure("Insert sort invalid!");
      return Left(failure);
    }
  }
}
