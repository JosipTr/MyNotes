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
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context
                      .read<NoteBloc>()
                      .add(const UpdateNoteOrderEvent('date'));
                  context.read<NoteBloc>().add(const GetAllNotesEvent());
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context
                      .read<NoteBloc>()
                      .add(const UpdateNoteOrderEvent('dateDesc'));
                  context.read<NoteBloc>().add(const GetAllNotesEvent());
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context
                      .read<NoteBloc>()
                      .add(const UpdateNoteOrderEvent('title'));
                  context.read<NoteBloc>().add(const GetAllNotesEvent());
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context
                      .read<NoteBloc>()
                      .add(const UpdateNoteOrderEvent('titleDesc'));
                  context.read<NoteBloc>().add(const GetAllNotesEvent());
                },
              ),
            ],
          )
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
