import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';
import 'package:flutter_notes/core/enums/update_notes_criteria.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

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
          color: state.notes[index].isSelected!
              ? Colors.blueGrey[200]
              : Theme.of(context).cardColor,
          child: ListTile(
            onLongPress: () {
              context.read<NoteBloc>().add(UpdateNotesEvent(
                  criteria: UpdateNotesCriteria.select,
                  id: state.notes[index].id));
              context.read<NoteBloc>().add(
                  const GetNotesEvent(criteria: GetNotesCriteria.selected));
            },
            onTap: () {
              context.go('/addNote', extra: state.notes[index]);
            },
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
                context.read<NoteBloc>().add(const UpdateNotesEvent(
                    criteria: UpdateNotesCriteria.delete));
                context.read<NoteBloc>().add(const GetNotesEvent());
              },
              icon: state.notes[index].isSelected!
                  ? Icon(
                      Icons.delete,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : const Nil(),
            ),
          ),
        );
      },
    );
  }
}
