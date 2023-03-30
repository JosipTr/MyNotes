import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/toggle_select_popup_widget.dart';
import '../widgets/add_note_button_widget.dart';
import '../widgets/menu_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/list_item_widget.dart';
import '../widgets/sort_popup_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuWidget(),
      floatingActionButton: const AddNoteButtonWidget(),
      appBar: AppBar(
        title: const Text(StringConstants.appbarHomeTitle),
        actions: [
          IconButton(
              onPressed: () => context.go(StringConstants.searchNotePageRoute),
              icon: const Icon(Icons.search)),
          const SortPopUpWidget(),
          const ToggleSelectPopUpWidget(),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.filter != current.filter,
        listener: (context, state) {
          context.read<NoteBloc>().add(const NoteAllUnselectEvent());
        },
        builder: (context, state) {
          if (state.status == NoteStatus.success) {
            if (state.filteredNotes.isEmpty) {
              return const EmptyListWidget(
                  message: 'You don\'t have any notes!',
                  iconPath: StringConstants.imageNotesEmpty);
            } else {
              return ListItemWidget(state: state);
            }
          }

          if (state.status == NoteStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == NoteStatus.failure) {
            return const Center(
              child: Text("Fail"),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
