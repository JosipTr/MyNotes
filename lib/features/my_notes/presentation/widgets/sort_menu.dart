import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.sort),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.arrow_upward,
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              Text('By date', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context.read<NoteBloc>().add(const UpdateNoteOrderEvent('date'));
            context.read<NoteBloc>().add(const GetAllNotesEvent());
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.arrow_downward,
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              Text('By date', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context
                .read<NoteBloc>()
                .add(const UpdateNoteOrderEvent('dateDesc'));
            context.read<NoteBloc>().add(const GetAllNotesEvent());
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.arrow_upward,
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              Text('By title', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context.read<NoteBloc>().add(const UpdateNoteOrderEvent('title'));
            context.read<NoteBloc>().add(const GetAllNotesEvent());
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.arrow_downward,
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              Text('By title', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context
                .read<NoteBloc>()
                .add(const UpdateNoteOrderEvent('titleDesc'));
            context.read<NoteBloc>().add(const GetAllNotesEvent());
          },
        ),
      ],
    );
  }
}
