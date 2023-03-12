import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class SelectMenu extends StatefulWidget {
  const SelectMenu({
    super.key,
  });

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

bool _isSelected = true;

class _SelectMenuState extends State<SelectMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: _isSelected
              ? const Text('Select all')
              : const Text('Unselect all'),
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
            context
                .read<NoteBloc>()
                .add(const GetAllNotesEvent(type: 'selectAll'));
          },
        ),
      ],
    );
  }
}
