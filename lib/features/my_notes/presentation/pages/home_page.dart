import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/empty_list.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('homepage build');
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MyNotes'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FloatingActionButton(
            child: const Icon(
              Icons.note_add,
            ),
            onPressed: () => context.go('/addNote'),
          ),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is Loaded) {
              return ListItem(state: state);
            }
            if (state is Empty) {
              return const EmptyList();
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
    });
  }
}
