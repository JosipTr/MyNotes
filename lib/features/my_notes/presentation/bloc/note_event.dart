import '../../domain/entities/note.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class InsertNoteEvent extends NoteEvent {
  final Note note;

  const InsertNoteEvent(this.note);
}

class RemoveNoteEvent extends NoteEvent {
  const RemoveNoteEvent();
}

class GetAllNotesEvent extends NoteEvent {
  const GetAllNotesEvent();
}

class GetAllSelectedNotesEvent extends NoteEvent {
  const GetAllSelectedNotesEvent();
}

class GetAllDeletedNotesEvent extends NoteEvent {
  const GetAllDeletedNotesEvent();
}

class GetAllSelectedDeletedNotesEvent extends NoteEvent {
  const GetAllSelectedDeletedNotesEvent();
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  const UpdateNoteEvent(this.note);
}

class SelectNoteEvent extends NoteEvent {
  final Note note;

  const SelectNoteEvent(this.note);
}

class SelectDeleteNoteEvent extends NoteEvent {
  final Note note;

  const SelectDeleteNoteEvent(this.note);
}

class SearchNoteEvent extends NoteEvent {
  final String searchText;

  const SearchNoteEvent(this.searchText);
}

class UpdateNoteOrderEvent extends NoteEvent {
  final String noteOrder;

  const UpdateNoteOrderEvent(this.noteOrder);
}

class RemoveDeletedNotesEvent extends NoteEvent {
  const RemoveDeletedNotesEvent();
}
