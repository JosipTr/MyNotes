import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/enums/update_notes_criteria.dart';

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
              Text('By title', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context.read<NoteBloc>().add(const UpdateNotesEvent(
                criteria: UpdateNotesCriteria.sortType, sortType: 'title'));
            context.read<NoteBloc>().add(const GetNotesEvent());
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Text('By date', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {
            context.read<NoteBloc>().add(const UpdateNotesEvent(
                criteria: UpdateNotesCriteria.sortType, sortType: 'date'));
            context.read<NoteBloc>().add(const GetNotesEvent());
          },
        ),
      ],
    );
  }
}
