import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';

class EmptyTrashPopUpWidget extends StatelessWidget {
  const EmptyTrashPopUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is Loaded) {
        return PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text(StringConstants.emptyTrash),
              onTap: () {
                context
                    .read<NoteBloc>()
                    .add(RemoveAllNotesEvent(notes: state.notes));
                context.read<NoteBloc>().add(const GetDeletedNotesEvent());
              },
            ),
          ],
        );
      } else {
        return PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text(StringConstants.emptyTrash),
            ),
          ],
        );
      }
    });
  }
}
