import 'package:dartz/dartz.dart';

import '../../features/my_notes/domain/entities/note.dart';
import '../../features/my_notes/domain/entities/sort.dart';
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
  final Stream<List<Note>> notes;
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
  final Stream<List<Note>> notes;

  const ToggleNoteSelectParams({required this.note, required this.notes});
}

class ToggleAllNotesSelectParams {
  final List<Note> notes;

  const ToggleAllNotesSelectParams({required this.notes});
}

class GetSelectedNotesParams {
  final List<Note> notes;

  const GetSelectedNotesParams({required this.notes});
}

class RemoveAllNotesParams {
  final List<Note> notes;

  const RemoveAllNotesParams({required this.notes});
}

class UpdateSortParams {
  final List<Note> notes;
  final String sortType;

  const UpdateSortParams({required this.sortType, required this.notes});
}
