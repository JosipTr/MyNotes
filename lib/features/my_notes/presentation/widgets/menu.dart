import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/colors/generate_material_color.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/notebook_header.png',
                    width: 100,
                    height: 100,
                  ),
                )),
            ListTile(
              leading: const Icon(
                Icons.note,
                color: labelColor,
              ),
              title: Text(
                'All notes',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {
                context.read<NoteBloc>().add(const GetAllNotesEvent());
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: labelColor,
              ),
              title: Text(
                'Trash',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<NoteBloc>()
                    .add(const GetAllNotesEvent(type: 'deleted'));
                context.go('/trashNote');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.folder_special,
                color: labelColor,
              ),
              title: Text(
                'Categorized',
                style: Theme.of(context).textTheme.labelMedium,
              ),
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
