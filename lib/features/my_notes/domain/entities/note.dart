import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Note extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isSelected;
  final bool isDeleted;
  final bool isFavorite;
  const Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isSelected = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });

  Note copyWith(
      {ValueGetter<int?>? id,
      String? title,
      String? description,
      String? date,
      bool? isSelected,
      bool? isDeleted,
      bool? isFavorite}) {
    return Note(
        id: id != null ? id() : this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        isSelected: isSelected ?? this.isSelected,
        isDeleted: isDeleted ?? this.isDeleted,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  @override
  List<Object> get props =>
      [id!, title, description, date, isSelected, isDeleted, isFavorite];
}
