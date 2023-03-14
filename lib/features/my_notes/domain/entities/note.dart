import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? content;
  final String? date;
  final bool? isSelected;
  final bool? isDeleted;
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.isSelected = false,
    this.isDeleted = false,
  });
}
