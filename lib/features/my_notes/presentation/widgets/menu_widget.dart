import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note_filter.dart';
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
                context.go('/');
                context
                    .read<NoteBloc>()
                    .add(const NoteFilterChanged(NoteViewFilter.all));

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
                context.go('/trashNote');
                context
                    .read<NoteBloc>()
                    .add(const NoteFilterChanged(NoteViewFilter.deletedOnly));
                Navigator.of(context).pop();
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
                context
                    .read<NoteBloc>()
                    .add(const NoteFilterChanged(NoteViewFilter.favoriteOnly));
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
