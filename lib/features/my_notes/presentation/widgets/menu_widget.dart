import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/generate_material_color.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import 'package:go_router/go_router.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

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
                context.read<NoteBloc>().add(const GetNotesEvent());
                context.go('/');
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
                context.read<NoteBloc>().add(const GetDeletedNotesEvent());
                Navigator.of(context).pop();
                context.go('/trashNote');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.folder_special,
                color: labelColor,
              ),
              title: Text(
                'Favorites',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {
                context.read<NoteBloc>().add(const GetFavoriteNotesEvent());
                Navigator.of(context).pop();
                context.go('/favoriteNote');
              },
            ),
          ],
        ),
      ),
    );
  }
}
