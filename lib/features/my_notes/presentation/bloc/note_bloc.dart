import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/get_notes.dart';

import '../../../../core/strings/string.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/insert_note.dart';
import '../../domain/usecases/remove_notes.dart';
import '../../domain/usecases/update_notes.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes _getNotes;
  final InsertNote _insertNote;
  final RemoveNotes _removeNotes;
  final UpdateNotes _updateNotes;

  NoteBloc(
    this._insertNote,
    this._getNotes,
    this._removeNotes,
    this._updateNotes,
  ) : super(const InitialState()) {
    on<GetNotesEvent>(_onGetNotesEvent);
    on<UpdateNotesEvent>(_onUpdateNotesEvent);
    on<InsertNoteEvent>(_onInsertNoteEvent);
    on<RemoveNotesEvent>(_onRemoveNotesEvent);
  }

  void _onGetNotesEvent(GetNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getNotes(
      params: Params(
          getNotesCriteria: event.criteria, searchText: event.searchValue),
    );

    either.fold((failure) => emit(Error(failure.toString())), (notes) {
      if (notes.isEmpty) {
        emit(const Empty('No notes added!'));
      } else {
        emit(Loaded(notes));
      }
    });
  }

  void _onUpdateNotesEvent(
      UpdateNotesEvent event, Emitter<NoteState> emit) async {
    await _updateNotes(
        params: Params(
            updateNotesCriteria: event.criteria,
            id: event.id,
            sortType: event.sortType,
            note: event.note));
  }

  void _onInsertNoteEvent(
      InsertNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _insertNote(params: Params(note: event.note));

    _transmitMessage(either, emit, onFailureMessage, onInsertNoteMessage);
  }

  void _onRemoveNotesEvent(
      RemoveNotesEvent event, Emitter<NoteState> emit) async {
    await _removeNotes(noParams: NoParams());
  }

  //Functions

  void _transmitMessage(either, emit, failureMessage, successMessage) {
    either.fold(
        (failure) => emit(
              const NoteModifiedState('Ooops! Something went wrong.'),
            ), (_) {
      emit(
        const NoteModifiedState('Note successfully added!'),
      );
    });
    emit(const Loading());
  }
}
