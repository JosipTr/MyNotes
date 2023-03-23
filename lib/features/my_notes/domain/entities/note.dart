import 'package:floor/floor.dart';

class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String title;
  String description;
  String date;
  bool isSelected;
  bool isDeleted;
  bool isFavorite;
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isSelected = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });
}
