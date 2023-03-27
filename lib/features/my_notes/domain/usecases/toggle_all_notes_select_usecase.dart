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
    // var counter = 0;
    // for (var note in params.notes) {
    //   if (note.isSelected) {
    //     counter++;
    //   }
    // }
    // if (counter >= 0 && counter < params.notes.length) {
    //   for (var note in params.notes) {
    //     note.isSelected = true;
    //   }
    // } else {
    //   for (var note in params.notes) {
    //     note.isSelected = false;
    //   }
    // }
    return const Right(Success());
  }
}
