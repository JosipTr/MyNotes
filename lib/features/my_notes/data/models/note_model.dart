import 'package:flutter_notes/features/my_notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {super.id,
      required super.title,
      required super.content,
      required super.dateTime});
}
