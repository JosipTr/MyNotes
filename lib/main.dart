import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/theme.dart';
import 'features/my_notes/presentation/bloc/note_bloc.dart';
import 'features/my_notes/presentation/bloc/note_event.dart';
import 'features/my_notes/presentation/pages/home_page.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => di()..add(const GetAllNotesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NotesApp',
        theme: getThemeData(),
        home: const HomePage(),
      ),
    );
  }
}
