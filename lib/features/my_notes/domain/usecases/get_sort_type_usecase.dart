import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

class GetSortTypeUseCase implements UseCase<String, NoParams> {
  final NoteRepository _noteRepository;

  const GetSortTypeUseCase(this._noteRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    final either = await _noteRepository.getSortType();
    return either.fold((l) => Left(l), (r) {
      if (r != null) {
        return Right(r);
      } else {
        return const Right("title");
      }
    });
  }
}
