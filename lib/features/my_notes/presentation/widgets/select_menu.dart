import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';

class SelectMenu extends StatelessWidget {
  const SelectMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is Loaded) {
        return PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text(StringConstants.selectAll),
              onTap: () {},
            ),
          ],
        );
      } else {
        return PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text(StringConstants.selectAll),
            ),
          ],
        );
      }
    });
  }
}
