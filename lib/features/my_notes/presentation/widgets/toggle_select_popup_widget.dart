import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';

class ToggleSelectPopUpWidget extends StatelessWidget {
  const ToggleSelectPopUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      return PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: state.filteredNotes.every((note) => note.isSelected == true)
                ? const Text(StringConstants.unSelectAll)
                : const Text(StringConstants.selectAll),
            onTap: () {
              context.read<NoteBloc>().add(const ToggleAllNotesSelectEvent());
            },
          ),
        ],
      );
    });
  }
}
