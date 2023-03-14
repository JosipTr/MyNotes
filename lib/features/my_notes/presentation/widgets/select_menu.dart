import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';
import 'package:flutter_notes/core/enums/update_notes_criteria.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class SelectMenu extends StatelessWidget {
  const SelectMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Select all'),
          onTap: () {
            context.read<NoteBloc>().add(const UpdateNotesEvent(
                criteria: UpdateNotesCriteria.selectAll));
            context
                .read<NoteBloc>()
                .add(const GetNotesEvent(criteria: GetNotesCriteria.selected));
          },
        ),
      ],
    );
  }
}
