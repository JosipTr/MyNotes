import 'package:flutter_notes/features/my_notes/domain/usecases/remove_all_notes_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/toggle_note_favorite_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/toggle_all_notes_select_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/toggle_note_select_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/unselect_all_notes.dart';

import 'get_notes_usecase.dart';
import 'insert_note_usecase.dart';
import 'remove_note_usecase.dart';
import 'set_note_deleted_usecase.dart';
import 'update_note_usecase.dart';

class NoteUseCases {
  final GetNotesUseCase getNotesUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final RemoveNoteUseCase removeNoteUseCase;
  final SetNoteDeletedUseCase setNoteDeletedUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final ToggleNoteSelectUseCase toggleNoteSelectUseCase;
  final ToggleAllNotesSelectUseCase setAllNotesUnselectedUseCase;
  final RemoveAllNotesUseCase removeAllNotesUseCase;
  final UnselectAllNotes unselectAllNotes;
  final ToggleNoteFavoriteUsecase toggleNoteFavorite;

  const NoteUseCases(
    this.getNotesUseCase,
    this.insertNoteUseCase,
    this.removeNoteUseCase,
    this.setNoteDeletedUseCase,
    this.updateNoteUseCase,
    this.toggleNoteSelectUseCase,
    this.setAllNotesUnselectedUseCase,
    this.removeAllNotesUseCase,
    this.unselectAllNotes,
    this.toggleNoteFavorite,
  );
}
