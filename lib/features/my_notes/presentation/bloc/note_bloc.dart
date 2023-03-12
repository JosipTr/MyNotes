import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/get_all_selected_deleted_notes.dart';

import '../../../../core/strings/string.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_all_deleted_notes.dart';
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/get_all_selected_notes.dart';
import '../../domain/usecases/get_searche_note.dart';
import '../../domain/usecases/insert_note.dart';
import '../../domain/usecases/remove_deleted_notes.dart';
import '../../domain/usecases/remove_note.dart';
import '../../domain/usecases/update_note.dart';

import '../../domain/usecases/update_note_order.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotes _getAllNotes;
  final InsertNote _insertNote;
  final RemoveNote _removeNote;
  final UpdateNote _updateNote;
  final GetAllSelectedNotes _getAllSelectedNotes;
  final GetSearchNote _getSearchNote;
  final UpdateNoteOrder _updateNoteOrder;
  final GetAllDeletedNotes _getAllDeletedNotes;
  final RemoveDeletedNotes _removeDeletedNotes;
  final GetAllSelectedDeletedNotes _getAllSelectedDeletedNotes;

  NoteBloc(
      this._getAllNotes,
      this._insertNote,
      this._removeNote,
      this._updateNote,
      this._getAllSelectedNotes,
      this._getSearchNote,
      this._updateNoteOrder,
      this._getAllDeletedNotes,
      this._removeDeletedNotes,
      this._getAllSelectedDeletedNotes)
      : super(const InitialState()) {
    on<GetAllNotesEvent>(_onGetAllNotes);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<InsertNoteEvent>(_onInsertNote);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<SelectNoteEvent>(_onSelectNoteEvent);
    on<GetAllSelectedNotesEvent>(_onGetAllSelectedNotes);
    on<SearchNoteEvent>(_onSearchNoteEvent);
    on<UpdateNoteOrderEvent>(_onUpdateNoteOrderEvent);
    on<GetAllDeletedNotesEvent>(_onGetAllDeletedNotes);
    on<SelectDeleteNoteEvent>(_onSelectDeleteNoteEvent);
    on<RemoveDeletedNotesEvent>(_onRemoveDeletedNotes);
    on<GetAllSelectedDeletedNotesEvent>(_onGetAllSelectedDeletedNotes);
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

  void _onGetAllDeletedNotes(
      GetAllDeletedNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getAllDeletedNotes(noParams: NoParams());

    _getNotes(either, emit);
  }

  void _onGetAllSelectedDeletedNotes(
      GetAllSelectedDeletedNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getAllSelectedDeletedNotes(noParams: NoParams());

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

  void _onSelectDeleteNoteEvent(
      SelectDeleteNoteEvent event, Emitter<NoteState> emit) async {
    event.note.isDeleted = !event.note.isDeleted!;
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

  void _onUpdateNoteOrderEvent(
      UpdateNoteOrderEvent event, Emitter<NoteState> emit) async {
    await _updateNoteOrder(params: Params(noteOrder: event.noteOrder));
  }

  void _onRemoveDeletedNotes(
      RemoveDeletedNotesEvent event, Emitter<NoteState> emit) async {
    await _removeDeletedNotes(noParams: NoParams());
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
