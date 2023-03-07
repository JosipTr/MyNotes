import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/insert_note.dart';
import '../../domain/usecases/remove_note.dart';
import '../../domain/usecases/update_note.dart';

import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotes _getAllNotes;
  final InsertNote _insertNote;
  final RemoveNote _removeNote;
  final UpdateNote _updateNote;

  NoteBloc(
      this._getAllNotes, this._insertNote, this._removeNote, this._updateNote)
      : super(const InitialState()) {
    on<GetAllNotesEvent>(_onGetAllNotes);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<InsertNoteEvent>(_onInsertNote);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<SelectNoteEvent>(_onSelectNoteEvent);
  }

  void _onGetAllNotes(GetAllNotesEvent event, Emitter<NoteState> emit) async {
    emit(const Loading());
    var either = await _getAllNotes(noParams: NoParams());
    either.fold((failure) => emit(Error(failure.toString())), (notes) {
      if (notes.isEmpty) {
        emit(const Empty());
      } else {
        emit(Loaded(notes));
      }
    });
  }

  void _onInsertNote(InsertNoteEvent event, Emitter<NoteState> emit) async {
    emit(const Loading());
    emit(const NoteModifiedState('Note successfully added'));
    await _insertNote(params: Params(event.note));
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NoteState> emit) async {
    emit(const Loading());
    emit(const NoteModifiedState('Note successfully removed'));
    await _removeNote(params: Params(event.note));
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    emit(const Loading());
    emit(const NoteModifiedState('Note successfully updated'));
    await _updateNote(params: Params(event.note));
  }

  void _onSelectNoteEvent(SelectNoteEvent event, Emitter<NoteState> emit) {
    event.note.isSelected = !event.note.isSelected!;
  }
}
