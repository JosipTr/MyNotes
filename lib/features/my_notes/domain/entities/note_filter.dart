import 'note.dart';

enum NoteViewFilter { all, deletedOnly, favoriteOnly }

extension NoteViewFilterX on NoteViewFilter {
  bool apply(Note note) {
    switch (this) {
      case NoteViewFilter.all:
        return !note.isDeleted;
      case NoteViewFilter.deletedOnly:
        return note.isDeleted;
      case NoteViewFilter.favoriteOnly:
        return note.isFavorite;
    }
  }

  List<Note> applyAll(List<Note> notes) {
    return notes.where(apply).toList();
  }
}
