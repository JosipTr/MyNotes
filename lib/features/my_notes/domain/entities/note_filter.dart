import 'note.dart';

enum NoteViewFilter { all, deletedOnly, favoriteOnly }

extension NoteViewFilterX on NoteViewFilter {
  bool apply(Note note) {
    switch (this) {
      case NoteViewFilter.all:
        return true;
      case NoteViewFilter.deletedOnly:
        return note.isDeleted;
      case NoteViewFilter.favoriteOnly:
        return note.isFavorite;
    }
  }

  Iterable<Note> applyAll(Iterable<Note> notes) {
    return notes.where(apply);
  }
}