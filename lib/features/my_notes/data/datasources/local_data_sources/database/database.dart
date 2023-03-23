// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_notes/features/my_notes/data/datasources/local_data_sources/database/sort_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../../domain/entities/sort.dart';
import '../../../models/note_model.dart';
import 'note_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [NoteModel, Sort])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
  SortDao get sortDao;
}
