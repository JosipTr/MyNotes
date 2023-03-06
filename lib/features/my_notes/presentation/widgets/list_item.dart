import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';

class ListItem extends StatelessWidget {
  final Loaded state;
  const ListItem({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.notes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 5,
          child: ListTile(
            onTap: () => context.go('/addNote', extra: state.notes[index]),
            title: Text(
              state.notes[index].title!,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.notes[index].content!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  state.notes[index].date!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                context
                    .read<NoteBloc>()
                    .add(RemoveNoteEvent(state.notes[index]));
                context.read<NoteBloc>().add(const GetAllNotesEvent());
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
