import 'package:flutter_notes/features/my_notes/domain/usecases/get_selected_notes_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/set_all_notes_unselected_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/toggle_note_select_usecase.dart';

import 'get_deleted_notes_usecase.dart';
import 'get_favorite_notes_usecase.dart';
import 'get_notes_usecase.dart';
import 'insert_note_usecase.dart';
import 'remove_note_usecase.dart';
import 'set_note_deleted_usecase.dart';
import 'update_note_usecase.dart';

class NoteUseCases {
  final GetNotesUseCase getNotesUseCase;
  final GetFavoriteNotesUsecase getFavoriteNotesUsecase;
  final GetDeletedNotesUseCase getDeletedNotesUseCase;
  final GetSelectedNotesUseCase getSelectedNotesUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final RemoveNoteUseCase removeNoteUseCase;
  final SetNoteDeletedUseCase setNoteDeletedUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final ToggleNoteSelectUseCase toggleNoteSelectUseCase;
  final SetAllNotesUnselectedUseCase setAllNotesUnselectedUseCase;

  const NoteUseCases(
      this.getNotesUseCase,
      this.getFavoriteNotesUsecase,
      this.getDeletedNotesUseCase,
      this.insertNoteUseCase,
      this.removeNoteUseCase,
      this.setNoteDeletedUseCase,
      this.updateNoteUseCase,
      this.toggleNoteSelectUseCase,
      this.setAllNotesUnselectedUseCase,
      this.getSelectedNotesUseCase);
}
