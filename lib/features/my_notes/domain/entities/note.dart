import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? title;
  String? content;
  String? date;
  bool? isSelected = false;
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}
