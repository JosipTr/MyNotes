import 'package:equatable/equatable.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note_filter.dart';

import '../../domain/entities/note.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [title, description];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  final String title;
  final String description;

  const UpdateNoteEvent(
      {required this.note, required this.title, required this.description});

  @override
  List<Object> get props => [note, title, description];
}

class RemoveNoteEvent extends NoteEvent {
  final List<Note> notes;

  const RemoveNoteEvent({required this.notes});

  @override
  List<Object> get props => [notes];
}

class SetNoteDeletedEvent extends NoteEvent {
  const SetNoteDeletedEvent();
}

class ToggleNoteSelectEvent extends NoteEvent {
  final Note note;

  const ToggleNoteSelectEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class ToggleAllNotesSelectEvent extends NoteEvent {
  const ToggleAllNotesSelectEvent();

  @override
  List<Object> get props => [];
}

class RemoveAllNotesEvent extends NoteEvent {
  final List<Note> notes;

  const RemoveAllNotesEvent({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NoteFilterChanged extends NoteEvent {
  final NoteViewFilter filter;

  const NoteFilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}

class NoteAllUnselectEvent extends NoteEvent {
  const NoteAllUnselectEvent();
}

class ToggleNoteFaovoriteEvent extends NoteEvent {
  final Note note;

  const ToggleNoteFaovoriteEvent(this.note);
}

//SortEvents

class GetSortTypeEvent extends NoteEvent {
  const GetSortTypeEvent();
}

class InsertSortEvent extends NoteEvent {
  const InsertSortEvent();
}

class UpdateSortEvent extends NoteEvent {
  final List<Note> notes;
  final String sortType;
  const UpdateSortEvent({required this.sortType, required this.notes});

  @override
  List<Object> get props => [notes, sortType];
}
