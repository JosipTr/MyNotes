import 'features/my_notes/domain/usecases/get_sort_type_usecase.dart';
import 'features/my_notes/domain/usecases/insert_sort_usecase.dart';
import 'features/my_notes/domain/usecases/remove_all_notes_usecase.dart';
import 'features/my_notes/domain/usecases/toggle_all_notes_select_usecase.dart';
import 'features/my_notes/domain/usecases/sort_usecases.dart';
import 'features/my_notes/domain/usecases/toggle_note_favorite_usecase.dart';
import 'features/my_notes/domain/usecases/toggle_note_select_usecase.dart';
import 'features/my_notes/domain/usecases/unselect_all_notes.dart';

import 'features/my_notes/domain/usecases/note_usecases.dart';
import 'features/my_notes/domain/usecases/set_note_deleted_usecase.dart';
import 'package:get_it/get_it.dart';

import 'features/my_notes/data/datasources/local_data_sources/database/database.dart';
import 'features/my_notes/data/datasources/local_data_sources/note_local_data_source.dart';
import 'features/my_notes/data/repositories/note_repository_impl.dart';
import 'features/my_notes/domain/repositories/note_repository.dart';
import 'features/my_notes/domain/usecases/get_notes_usecase.dart';
import 'features/my_notes/domain/usecases/insert_note_usecase.dart';
import 'features/my_notes/domain/usecases/remove_note_usecase.dart';
import 'features/my_notes/domain/usecases/update_note_usecase.dart';
import 'features/my_notes/domain/usecases/update_sort_usecase.dart';
import 'features/my_notes/presentation/bloc/note_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  di.registerSingleton(database);

  //Bloc
  di.registerFactory(() => NoteBloc(di(), di()));

  //UseCases
  di.registerLazySingleton(() => UpdateNoteUseCase(di()));
  di.registerLazySingleton(() => GetNotesUseCase(di()));
  di.registerLazySingleton(() => InsertNoteUseCase(di()));
  di.registerLazySingleton(() => RemoveNoteUseCase(di()));
  di.registerLazySingleton(() => SetNoteDeletedUseCase(di()));
  di.registerLazySingleton(() => ToggleNoteSelectUseCase(di()));
  di.registerLazySingleton(() => ToggleAllNotesSelectUseCase(di()));
  di.registerLazySingleton(() => RemoveAllNotesUseCase(di()));
  di.registerLazySingleton(() => UnselectAllNotes(di()));
  di.registerLazySingleton(() => ToggleNoteFavoriteUsecase(di()));
  di.registerLazySingleton(() =>
      NoteUseCases(di(), di(), di(), di(), di(), di(), di(), di(), di(), di()));

  di.registerLazySingleton(() => GetSortTypeUseCase(di()));
  di.registerLazySingleton(() => InsertSortUseCase(di()));
  di.registerLazySingleton(() => UpdateSortUseCase(di()));
  di.registerLazySingleton(() => SortUseCases(di(), di(), di()));

  //Repository
  di.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(di()));

  //Datasources
  di.registerLazySingleton<NoteLocalDataSource>(
      () => NoteLocalDataSourceImpl(di()));
}
