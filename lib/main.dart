import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/colors/generate_material_color.dart';

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
        title: 'NotesApp',
        theme: ThemeData(
          textTheme: const TextTheme(
            labelLarge: TextStyle(
              color: Color.fromRGBO(43, 52, 103, 1),
            ),
          ),
          cardColor: const Color.fromRGBO(252, 255, 231, 1),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: generateMaterialColor(
              const Color.fromRGBO(43, 52, 103, 1),
            ),
          ).copyWith(
            background: const Color.fromRGBO(186, 215, 233, 1),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
