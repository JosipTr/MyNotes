import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/success.dart';
import '../../../../core/usecases/usecase.dart';

class ToggleNoteSelectUseCase
    implements UseCase<Success, ToggleNoteSelectParams> {
  const ToggleNoteSelectUseCase();

  @override
  Future<Either<Failure, Success>> call(ToggleNoteSelectParams params) async {
    // params.note.isSelected = !params.note.isSelected;
    return const Right(Success());
  }
}
