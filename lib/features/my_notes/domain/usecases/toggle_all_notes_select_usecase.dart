import 'package:flutter_notes/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/usecases/usecase.dart';

import '../../../../core/errors/success.dart';

class ToggleAllNotesSelectUseCase
    implements UseCase<Success, ToggleAllNotesSelectParams> {
  const ToggleAllNotesSelectUseCase();

  @override
  Future<Either<Failure, Success>> call(
      ToggleAllNotesSelectParams params) async {
    for (var note in params.notes) {
      note.isSelected = !note.isSelected;
    }
    return const Right(Success());
  }
}
