import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/strings/string.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/get_all_selected_notes.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/get_searche_note.dart';

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
  final GetAllSelectedNotes _getAllSelectedNotes;
  final GetSearchNote _getSearchNote;

  NoteBloc(this._getAllNotes, this._insertNote, this._removeNote,
      this._updateNote, this._getAllSelectedNotes, this._getSearchNote)
      : super(const InitialState()) {
    on<GetAllNotesEvent>(_onGetAllNotes);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<InsertNoteEvent>(_onInsertNote);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<SelectNoteEvent>(_onSelectNoteEvent);
    on<GetAllSelectedNotesEvent>(_onGetAllSelectedNotes);
    on<SearchNoteEvent>(_onSearchNoteEvent);
  }

  void _onGetAllNotes(GetAllNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getAllNotes(noParams: NoParams());

    _getNotes(either, emit);
  }

  void _onGetAllSelectedNotes(
      GetAllSelectedNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getAllSelectedNotes(noParams: NoParams());

    _getNotes(either, emit);
  }

  void _onInsertNote(InsertNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _insertNote(params: Params(note: event.note));

    _transmitMessage(either, emit, onFailureMessage, onInsertNoteMessage);
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _removeNote(noParams: NoParams());
    _transmitMessage(either, emit, onFailureMessage, onRemoveNoteMessage);
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _updateNote(params: Params(note: event.note));
    _transmitMessage(either, emit, onFailureMessage, onUpdateNoteMessage);
  }

  void _onSelectNoteEvent(
      SelectNoteEvent event, Emitter<NoteState> emit) async {
    event.note.isSelected = !event.note.isSelected!;
    await _updateNote(params: Params(note: event.note));
  }

  void _onSearchNoteEvent(
      SearchNoteEvent event, Emitter<NoteState> emit) async {
    final either =
        await _getSearchNote(params: Params(searchText: event.searchText));

    if (event.searchText.isEmpty) {
      emit(const Empty(''));
    } else {
      either.fold((failure) => emit(Error(failure.toString())),
          (notes) => emit(SearchNoteLoaded(notes)));
    }
  }

  //Functions

  void _getNotes(either, emit) {
    either.fold((failure) => emit(Error(failure.toString())), (notes) {
      if (notes.isEmpty) {
        emit(const Empty('No notes added!'));
      } else {
        emit(Loaded(notes));
      }
    });
  }

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
