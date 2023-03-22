import '../../domain/entities/note.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class GetNotesEvent extends NoteEvent {
  const GetNotesEvent();
}

class GetDeletedNotesEvent extends NoteEvent {
  const GetDeletedNotesEvent();
}

class GetFavoriteNotesEvent extends NoteEvent {
  const GetFavoriteNotesEvent();
}

class InsertNoteEvent extends NoteEvent {
  final String title;
  final String description;

  const InsertNoteEvent({required this.title, required this.description});
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  final String title;
  final String description;

  const UpdateNoteEvent(
      {required this.note, required this.title, required this.description});
}

class RemoveNoteEvent extends NoteEvent {
  final List<Note> notes;

  const RemoveNoteEvent({required this.notes});
}

class SetNoteDeletedEvent extends NoteEvent {
  final List<Note> notes;

  const SetNoteDeletedEvent({required this.notes});
}

class ToggleNoteSelectEvent extends NoteEvent {
  final List<Note> notes;
  final Note note;

  const ToggleNoteSelectEvent({required this.note, required this.notes});
}

class ToggleAllNotesSelectEvent extends NoteEvent {
  final List<Note> notes;

  const ToggleAllNotesSelectEvent({required this.notes});
}

//SortEvents

class GetSortTypeEvent extends NoteEvent {
  const GetSortTypeEvent();
}

class InsertSortEvent extends NoteEvent {
  const InsertSortEvent();
}
