import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/constants/strings/string_constants.dart';
import 'package:flutter_notes/features/my_notes/domain/entities/note_filter.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';

class ListItemWidget extends StatelessWidget {
  final NoteState state;
  const ListItemWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final note in state.filteredNotes)
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 5,
            color: note.isSelected
                ? Colors.blueGrey[200]
                : Theme.of(context).cardColor,
            child: ListTile(
                onLongPress: () {
                  context
                      .read<NoteBloc>()
                      .add(ToggleNoteSelectEvent(note: note));
                },
                onTap: () {
                  context.go(StringConstants.updateNotePageRoute, extra: note);
                },
                title: Text(
                  note.title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.description,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      note.date,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                trailing: note.isSelected == false &&
                        (state.filter == NoteViewFilter.all ||
                            state.filter == NoteViewFilter.favoriteOnly)
                    ? IconButton(
                        onPressed: () {
                          context
                              .read<NoteBloc>()
                              .add(ToggleNoteFaovoriteEvent(note));
                        },
                        icon: note.isFavorite
                            ? Icon(
                                Icons.star,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : Icon(
                                Icons.star_border,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      )
                    : IconButton(
                        onPressed: () {
                          if (state.filter == NoteViewFilter.deletedOnly) {
                            context.read<NoteBloc>().add(
                                RemoveNoteEvent(notes: state.filteredNotes));
                          }
                          context
                              .read<NoteBloc>()
                              .add(const SetNoteDeletedEvent());
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )),
          ),
      ],
    );
  }
}
