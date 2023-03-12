import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class SelectMenu extends StatelessWidget {
  final String type;
  const SelectMenu({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Select all'),
          onTap: () {
            context.read<NoteBloc>().add(GetAllNotesEvent(type: type));
          },
        ),
      ],
    );
  }
}
