import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('All notes'),
              onTap: () {
                context.read<NoteBloc>().add(const GetAllNotesEvent());
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Trash'),
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<NoteBloc>()
                    .add(const GetAllNotesEvent(type: 'deleted'));
                context.go('/trashNote');
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_special),
              title: const Text('Categorized'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
