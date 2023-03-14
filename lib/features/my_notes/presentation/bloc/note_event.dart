import 'package:flutter_notes/core/enums/get_notes_criteria.dart';
import 'package:flutter_notes/core/enums/update_notes_criteria.dart';

import '../../domain/entities/note.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class InsertNoteEvent extends NoteEvent {
  final Note note;

  const InsertNoteEvent(this.note);
}

class GetNotesEvent extends NoteEvent {
  final GetNotesCriteria? criteria;
  final String? searchValue;

  const GetNotesEvent({this.criteria, this.searchValue});
}

class UpdateNotesEvent extends NoteEvent {
  final UpdateNotesCriteria? criteria;
  final int? id;
  final String? sortType;
  final Note? note;

  const UpdateNotesEvent({this.criteria, this.id, this.sortType, this.note});
}

class RemoveNotesEvent extends NoteEvent {
  const RemoveNotesEvent();
}
