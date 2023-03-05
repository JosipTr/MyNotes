import '../../domain/entities/note.dart';

abstract class NoteState {
  const NoteState();
}

class InitialState extends NoteState {
  const InitialState();
}

class Empty extends NoteState {
  const Empty();
}

class Loading extends NoteState {
  const Loading();
}

class Loaded extends NoteState {
  final List<Note> notes;

  const Loaded(this.notes);
}

class Error extends NoteState {
  final String message;

  const Error(this.message);
}