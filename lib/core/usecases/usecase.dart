import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';
import 'package:flutter_notes/core/errors/failure.dart';

import '../../features/my_notes/domain/entities/note.dart';
import '../enums/update_notes_criteria.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call();
}

class NoParams {}

class Params {
  final Note? note;
  final String? searchText;
  final GetNotesCriteria? getNotesCriteria;
  final String? sortType;
  final UpdateNotesCriteria? updateNotesCriteria;
  final int? id;
  const Params({
    this.note,
    this.searchText,
    this.getNotesCriteria,
    this.sortType,
    this.updateNotesCriteria,
    this.id,
  });
}
