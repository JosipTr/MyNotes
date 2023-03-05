import 'package:floor/floor.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note.dart';

@entity
class NoteModel extends Note {
  @override
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @override
  final String? title;
  @override
  final String? content;

  NoteModel(this.id, this.title, this.content)
      : super(id: id, title: title, content: content);
}
