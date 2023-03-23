import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/toggle_select_widget.dart';
import '../widgets/add_note_widget.dart';
import '../widgets/menu_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/strings/string_constants.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/list_item_widget.dart';
import '../widgets/select_menu_widget.dart';
import '../widgets/sort_menu_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuWidget(),
      floatingActionButton: const AddNoteWidget(),
      appBar: AppBar(
        title: const Text(StringConstants.appbarHomeTitle),
        actions: [
          IconButton(
              onPressed: () => context.go(StringConstants.searchNotePageRoute),
              icon: const Icon(Icons.search)),
          const SortMenuWidget(),
          const ToggleSelectWidget(),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteModifiedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is Loaded) {
            return ListItemWidget(state: state);
          }
          if (state is Empty) {
            return EmptyListWidget(
                message: state.message,
                iconPath: StringConstants.imageNotesEmpty);
          }
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
