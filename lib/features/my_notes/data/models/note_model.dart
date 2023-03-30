import '../../domain/entities/note.dart';
import 'package:floor/floor.dart';

@entity
class NoteModel extends Note {
  const NoteModel(
      {super.id,
      required super.title,
      required super.description,
      required super.date,
      super.isSelected,
      super.isDeleted,
      super.isFavorite});

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      description: note.description,
      date: note.date,
      isSelected: note.isSelected,
      isDeleted: note.isDeleted,
      isFavorite: note.isFavorite,
    );
  }

  Note toNote() {
    return Note(
      id: id,
      title: title,
      description: description,
      date: date,
      isSelected: isSelected,
      isDeleted: isDeleted,
      isFavorite: isFavorite,
    );
  }
}
