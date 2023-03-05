import '../../domain/entities/note.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class InsertNoteEvent extends NoteEvent {
  final Note note;

  const InsertNoteEvent(this.note);
}

class RemoveNoteEvent extends NoteEvent {
  final Note note;

  const RemoveNoteEvent(this.note);
}

class GetAllNotesEvent extends NoteEvent {
  const GetAllNotesEvent();
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  const UpdateNoteEvent(this.note);
}
