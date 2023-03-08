import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/note.dart';
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

  var i = 0;
  var noteList = List<Note>.empty(growable: true);

  void unSelectAll() {
    for (i = 0; i < noteList.length; i++) {
      if (noteList[i].isSelected!) {
        noteList[i].isSelected = false;
        _updateNote(params: Params(noteList[i]));
      }
    }
  }

  void _onGetAllNotes(GetAllNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _getAllNotes(noParams: NoParams());

    either.fold((failure) => emit(Error(failure.toString())), (notes) {
      if (notes.isEmpty) {
        emit(const Empty());
      } else {
        noteList = notes;
        unSelectAll();
        emit(Loaded(noteList));
      }
    });
  }

  void _onInsertNote(InsertNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _insertNote(params: Params(event.note));
    noteList.add(event.note);
    either.fold(
        (failure) => emit(
              const NoteModifiedState('Ooops! Something went wrong.'),
            ), (_) {
      emit(
        const NoteModifiedState('Note successfully added!'),
      );
      emit(const Loading());
    });
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _removeNote(params: Params(event.note));
    noteList.remove(event.note);
    either.fold(
        (failure) => emit(
              const NoteModifiedState('Ooops! Something went wrong.'),
            ), (_) {
      emit(
        const NoteModifiedState('Note successfully removed!'),
      );
      emit(const Loading());
    });
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _updateNote(params: Params(event.note));
    final index = noteList.indexWhere((element) => element.id == event.note.id);
    noteList[index] = event.note;
    either.fold(
        (failure) => emit(
              const NoteModifiedState('Ooops! Something went wrong.'),
            ), (_) {
      emit(
        const NoteModifiedState('Note successfully updated!'),
      );
      emit(const Loading());
    });
  }

  void _onSelectNoteEvent(
      SelectNoteEvent event, Emitter<NoteState> emit) async {
    event.note.isSelected = !event.note.isSelected!;
    await _updateNote(params: Params(event.note));
    final index = noteList.indexWhere((element) => element.id == event.note.id);
    noteList[index] = event.note;
    emit(Loaded(noteList));
  }
}
