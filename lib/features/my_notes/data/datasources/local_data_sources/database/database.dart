// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../../domain/entities/note.dart';
import '../../../models/note_model.dart';
import 'note_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [NoteModel])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
