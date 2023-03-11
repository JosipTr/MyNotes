import 'package:flutter_notes/features/my_notes/domain/usecases/get_all_selected_notes.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/get_searche_note.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/update_note_order.dart';
import 'package:get_it/get_it.dart';

import './features/my_notes/data/datasources/local_data_sources/database/database.dart';
import './features/my_notes/domain/usecases/get_all_notes.dart';
import 'features/my_notes/data/datasources/local_data_sources/note_local_data_source.dart';
import 'features/my_notes/data/repositories/note_repository_impl.dart';
import 'features/my_notes/domain/repositories/note_repository.dart';
import 'features/my_notes/domain/usecases/insert_note.dart';
import 'features/my_notes/domain/usecases/remove_note.dart';
import 'features/my_notes/domain/usecases/update_note.dart';
import 'features/my_notes/presentation/bloc/note_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  di.registerSingleton(database);

  //Bloc
  di.registerFactory(() => NoteBloc(di(), di(), di(), di(), di(), di(), di()));

  //UseCases
  di.registerLazySingleton(() => GetAllNotes(di()));
  di.registerLazySingleton(() => InsertNote(di()));
  di.registerLazySingleton(() => RemoveNote(di()));
  di.registerLazySingleton(() => UpdateNote(di()));
  di.registerLazySingleton(() => GetAllSelectedNotes(di()));
  di.registerLazySingleton(() => GetSearchNote(di()));
  di.registerLazySingleton(() => UpdateNoteOrder(di()));

  //Repository
  di.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(di()));

  //Datasources
  di.registerLazySingleton<NoteLocalDataSource>(
      () => NoteLocalDataSourceImpl(di()));
}
