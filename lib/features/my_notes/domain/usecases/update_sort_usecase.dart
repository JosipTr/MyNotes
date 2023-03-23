import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/features/my_notes/domain/repositories/note_repository.dart';

import '../../../../core/errors/success.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateSortUseCase implements UseCase<Success, UpdateSortParams> {
  final NoteRepository _noteRepository;

  const UpdateSortUseCase(this._noteRepository);

  @override
  Future<Either<Failure, Success>> call(UpdateSortParams params) async {
    await _noteRepository.updateSort(params.sortType);
    params.notes.sort((a, b) {
      switch (params.sortType) {
        case "title":
          return a.title.compareTo(b.title);
        case "date":
          return a.date.compareTo(b.date);
        case "titleDesc":
          return b.title.compareTo(a.title);
        case "dateDesc":
          return b.date.compareTo(a.date);
        default:
          return a.title.compareTo(b.title);
      }
    });
    return const Right(Success());
  }
}
