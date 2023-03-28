import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/constants/strings/string_constants.dart';
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
    return ListView.builder(
      itemCount: state.notes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 5,
          color: state.notes[index].isSelected
              ? Colors.blueGrey[200]
              : Theme.of(context).cardColor,
          child: ListTile(
            onLongPress: () {
              context
                  .read<NoteBloc>()
                  .add(ToggleNoteSelectEvent(note: state.notes[index]));
            },
            onTap: () {
              context.go(StringConstants.updateNotePageRoute,
                  extra: state.notes[index]);
            },
            title: Text(
              state.notes[index].title,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.notes[index].description,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  state.notes[index].date,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            trailing: state.notes[index].isSelected
                ? IconButton(
                    onPressed: () {
                      context.read<NoteBloc>().add(const SetNoteDeletedEvent());
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: state.notes[index].isFavorite
                        ? Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                  ),
          ),
        );
      },
    );
  }
}
