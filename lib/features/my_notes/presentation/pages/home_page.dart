import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widgets/list_item.dart';
import 'add_modify_note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyNotes'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddModifyNotePage();
                },
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is Loaded) {
            return ListItem(state: state);
          }
          if (state is Empty) {
            return const Center(
              child: Text('Empty list'),
            );
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
            return const Center(
              child: Text('Unexpected error'),
            );
          }
        },
      ),
    );
  }
}
