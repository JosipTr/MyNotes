import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';

import '../../features/my_notes/domain/entities/note.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call();
}

class NoParams {}

class Params {
  final Note? note;
  final String? searchText;
  final String? noteOrder;
  const Params({
    this.note,
    this.searchText,
    this.noteOrder,
  });
}
