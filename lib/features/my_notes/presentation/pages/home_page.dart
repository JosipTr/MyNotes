import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/menu.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/strings/string.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../widgets/empty_list.dart';
import '../widgets/list_item.dart';
import '../widgets/select_menu.dart';
import '../widgets/sort_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FloatingActionButton(
          child: const Icon(
            Icons.note_add,
          ),
          onPressed: () => context.go(addNotePageRoute),
        ),
      ),
      appBar: AppBar(
        title: const Text('MyNotes'),
        actions: [
          IconButton(
              onPressed: () => context.go(searchNotePageRoute),
              icon: const Icon(Icons.search)),
          const SortMenu(),
          const SelectMenu(
            type: 'selectAllNormal',
          ),
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
            return ListItem(state: state);
          }
          if (state is Empty) {
            return EmptyList(
                message: state.message, iconPath: 'assets/images/post-it.png');
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
