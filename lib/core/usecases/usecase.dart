import 'package:dartz/dartz.dart';

import '../../features/my_notes/domain/entities/note.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class InsertNoteParams {
  final String title;
  final String description;
  const InsertNoteParams({required this.title, required this.description});
}

class SetNoteDeletedParams {
  final List<Note> notes;
  const SetNoteDeletedParams({required this.notes});
}

class UpdateNoteParams {
  final Note note;
  final String title;
  final String description;
  const UpdateNoteParams(
      {required this.note, required this.title, required this.description});
}

class RemoveNoteParams {
  final List<Note> notes;

  const RemoveNoteParams({required this.notes});
}

class ToggleNoteSelectParams {
  final Note note;

  const ToggleNoteSelectParams({required this.note});
}

class SetAllNotesUnselectedParams {
  final List<Note> notes;

  const SetAllNotesUnselectedParams({required this.notes});
}
