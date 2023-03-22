import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/constants/strings/string_constants.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/sort_usecases.dart';

import '../../domain/usecases/note_usecases.dart';
import '../../../../core/usecases/usecase.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteUseCases _noteUseCases;
  final SortUseCases _sortUseCases;

  NoteBloc(this._noteUseCases, this._sortUseCases)
      : super(const InitialState()) {
    on<GetNotesEvent>(_onGetNotesEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<InsertNoteEvent>(_onInsertNoteEvent);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<ToggleNoteSelectEvent>(_onToggleNoteSelectEvent);
    on<InsertSortEvent>(_onInsertSortEvent);
    on<SetNoteDeletedEvent>(_onSetNoteDeletedEvent);
    on<GetDeletedNotesEvent>(_onGetDeletedNotesEvent);
    on<GetFavoriteNotesEvent>(_onGetFavoriteNotesEvent);
    on<ToggleAllNotesSelectEvent>(_onToggleAllNotesSelectEvent);
  }

  void _onGetNotesEvent(GetNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.getNotesUseCase(NoParams());

    either.fold((failure) => emit(Error(failure.message)), (notes) {
      if (notes.isEmpty) {
        emit(const Empty(StringConstants.emptyListMessage));
      } else {
        emit(Loaded(notes));
      }
    });
  }

  void _onGetDeletedNotesEvent(
      GetDeletedNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.getDeletedNotesUseCase(NoParams());

    either.fold((failure) => emit(Error(failure.message)), (notes) {
      if (notes.isEmpty) {
        emit(const Empty(StringConstants.emptyTrashMessage));
      } else {
        emit(Loaded(notes));
      }
    });
  }

  void _onGetFavoriteNotesEvent(
      GetFavoriteNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.getFavoriteNotesUsecase(NoParams());

    either.fold((failure) => emit(Error(failure.message)), (notes) {
      if (notes.isEmpty) {
        emit(const Empty(StringConstants.emptyFavoriteMessage));
      } else {
        emit(Loaded(notes));
      }
    });
  }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.updateNoteUseCase(UpdateNoteParams(
        note: event.note, title: event.title, description: event.description));
    either.fold(
        (failure) => emit(NoteModifiedState(failure.message)),
        (success) =>
            emit(const NoteModifiedState(StringConstants.onUpdateNoteMessage)));
  }

  void _onInsertNoteEvent(
      InsertNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.insertNoteUseCase(
        InsertNoteParams(title: event.title, description: event.description));

    either.fold(
        (failure) => emit(NoteModifiedState(failure.message)),
        (success) =>
            emit(const NoteModifiedState(StringConstants.onInsertNoteMessage)));
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases
        .removeNoteUseCase(RemoveNoteParams(notes: event.notes));
    either.fold(
        (failure) => emit(NoteModifiedState(failure.message)),
        (success) =>
            emit(const NoteModifiedState(StringConstants.onRemoveNoteMessage)));
    emit(Loaded(event.notes));
  }

  void _onToggleNoteSelectEvent(
      ToggleNoteSelectEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases
        .toggleNoteSelectUseCase(ToggleNoteSelectParams(note: event.note));
    emit(Loaded(event.notes));
  }

  void _onSetNoteDeletedEvent(
      SetNoteDeletedEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases
        .setNoteDeletedUseCase(SetNoteDeletedParams(notes: event.notes));
    either.fold(
        (failure) => emit(NoteModifiedState(failure.message)),
        (success) =>
            emit(const NoteModifiedState(StringConstants.onRemoveNoteMessage)));
    emit(Loaded(event.notes));
  }

  void _onToggleAllNotesSelectEvent(
      ToggleAllNotesSelectEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.setAllNotesUnselectedUseCase(
        ToggleAllNotesSelectParams(notes: event.notes));
    emit(Loaded(event.notes));
  }

  //Sort

  void _onGetSortTypeEvent(
      GetSortTypeEvent event, Emitter<NoteState> emit) async {
    await _sortUseCases.getSortTypeUseCase(NoParams());
  }

  void _onInsertSortEvent(
      InsertSortEvent event, Emitter<NoteState> emit) async {
    await _sortUseCases.insertSortUseCase(NoParams());
  }
}
