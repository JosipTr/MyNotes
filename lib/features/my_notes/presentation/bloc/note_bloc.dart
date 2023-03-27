import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/constants/strings/string_constants.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/sort_usecases.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/note_usecases.dart';
import '../../../../core/usecases/usecase.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteUseCases _noteUseCases;
  final SortUseCases _sortUseCases;

  NoteBloc(this._noteUseCases, this._sortUseCases) : super(const NoteState()) {
    on<GetNotesEvent>(_onGetNotesEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<InsertNoteEvent>(_onInsertNoteEvent);
    on<RemoveNoteEvent>(_onRemoveNoteEvent);
    on<ToggleNoteSelectEvent>(_onToggleNoteSelectEvent);
    on<InsertSortEvent>(_onInsertSortEvent);
    on<SetNoteDeletedEvent>(_onSetNoteDeletedEvent);
    // on<GetDeletedNotesEvent>(_onGetDeletedNotesEvent);
    // on<GetFavoriteNotesEvent>(_onGetFavoriteNotesEvent);
    on<ToggleAllNotesSelectEvent>(_onToggleAllNotesSelectEvent);
    on<RemoveAllNotesEvent>(_onRemoveAllNotesEvent);
    on<UpdateSortEvent>(_onUpdateSortEvent);
    on<NoteFilterChanged>(_onFilterChanged);
  }

  Stream<List<Note>> noteStream = const Stream.empty();
  void _onGetNotesEvent(GetNotesEvent event, Emitter<NoteState> emit) async {
    final either = await _noteUseCases.getNotesUseCase(NoParams());

    return either.fold(
        (failure) => emit(state.copyWith(status: NoteStatus.failure)), (notes) {
      noteStream = notes;
      return emit.forEach<List<Note>>(
        notes,
        onData: (notes) =>
            state.copyWith(notes: notes, status: NoteStatus.success),
        onError: (_, __) => state.copyWith(status: NoteStatus.failure),
      );
    });
  }

  void _onFilterChanged(NoteFilterChanged event, Emitter<NoteState> emit) {
    emit(state.copyWith(filter: event.filter));
  }
  // void _onGetDeletedNotesEvent(
  //     GetDeletedNotesEvent event, Emitter<NoteState> emit) async {
  //   final either = await _noteUseCases.getDeletedNotesUseCase(NoParams());

  //   either.fold((failure) => emit(Error(failure.message)), (notes) {
  //     if (notes.isEmpty) {
  //       emit(const Empty(StringConstants.emptyTrashMessage));
  //     } else {
  //       emit(Loaded(notes));
  //     }
  //   });
  // }

  // void _onGetFavoriteNotesEvent(
  //     GetFavoriteNotesEvent event, Emitter<NoteState> emit) async {
  //   final either = await _noteUseCases.getFavoriteNotesUsecase(NoParams());

  //   either.fold((failure) => emit(Error(failure.message)), (notes) {
  //     if (notes.isEmpty) {
  //       emit(const Empty(StringConstants.emptyFavoriteMessage));
  //     } else {
  //       emit(Loaded(notes));
  //     }
  //   });
  // }

  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.updateNoteUseCase(UpdateNoteParams(
        note: event.note, title: event.title, description: event.description));
  }

  void _onInsertNoteEvent(
      InsertNoteEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.insertNoteUseCase(
        InsertNoteParams(title: event.title, description: event.description));
  }

  void _onRemoveNoteEvent(
      RemoveNoteEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.removeNoteUseCase(RemoveNoteParams(notes: event.notes));
  }

  void _onToggleNoteSelectEvent(
      ToggleNoteSelectEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.toggleNoteSelectUseCase(
        ToggleNoteSelectParams(note: event.note, notes: noteStream));
  }

  void _onSetNoteDeletedEvent(
      SetNoteDeletedEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases
        .setNoteDeletedUseCase(SetNoteDeletedParams(notes: noteStream));
  }

  void _onToggleAllNotesSelectEvent(
      ToggleAllNotesSelectEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases.setAllNotesUnselectedUseCase(
        ToggleAllNotesSelectParams(notes: event.notes));
  }

  void _onRemoveAllNotesEvent(
      RemoveAllNotesEvent event, Emitter<NoteState> emit) async {
    await _noteUseCases
        .removeAllNotesUseCase(RemoveAllNotesParams(notes: event.notes));
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

  void _onUpdateSortEvent(
      UpdateSortEvent event, Emitter<NoteState> emit) async {
    await _sortUseCases.updateSortUseCase(
        UpdateSortParams(sortType: event.sortType, notes: event.notes));
  }
}
