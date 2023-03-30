import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/list_item_widget.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/sort_popup_widget.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/empty_trash_popup_widget.dart';
import '../widgets/menu_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';

class TrashNotePage extends StatelessWidget {
  const TrashNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
                context.go(StringConstants.searchNotePageRoute);
              },
              icon: const Icon(Icons.search)),
          const SortPopUpWidget(),
          const EmptyTrashPopUpWidget()
        ],
      ),
      drawer: const MenuWidget(),
      body: WillPopScope(
        onWillPop: () async {
          context.read<NoteBloc>().add(const GetNotesEvent());
          return true;
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state.filteredNotes.isEmpty) {
              return const EmptyListWidget(
                  message: 'Trash is Empty!',
                  iconPath: StringConstants.imageTrashEmpty);
            } else {
              return ListItemWidget(
                state: state,
              );
            }
          },
        ),
      ),
    );
  }
}
