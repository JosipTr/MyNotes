import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    super.id,
    required super.title,
    required super.content,
    required super.date,
    required super.isSelected,
    required super.isDeleted,
  });

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      date: note.date,
      isSelected: note.isSelected,
      isDeleted: note.isDeleted,
    );
  }

  Note toNote() {
    return Note(
      id: id,
      title: title,
      content: content,
      date: date,
      isSelected: isSelected,
      isDeleted: isDeleted,
    );
  }
}
