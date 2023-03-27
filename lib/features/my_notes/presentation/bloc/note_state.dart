import 'package:equatable/equatable.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note_filter.dart';

import '../../domain/entities/note.dart';

enum NoteStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;
  final NoteViewFilter filter;
  const NoteState({
    this.status = NoteStatus.initial,
    this.notes = const [],
    this.filter = NoteViewFilter.all,
  });

  Iterable<Note> get filteredNotes => filter.applyAll(notes);

  NoteState copyWith(
      {NoteStatus? status, List<Note>? notes, NoteViewFilter? filter}) {
    return NoteState(
        status: status ?? this.status,
        notes: notes ?? this.notes,
        filter: filter ?? this.filter);
  }

  @override
  List<Object> get props => [status, notes, filter];
}
