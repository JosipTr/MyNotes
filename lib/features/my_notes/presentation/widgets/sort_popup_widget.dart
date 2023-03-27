import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';

import '../bloc/note_state.dart';

class SortPopUpWidget extends StatelessWidget {
  const SortPopUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state.status == NoteStatus.success) {
          return PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context.read<NoteBloc>().add(
                      UpdateSortEvent(sortType: 'title', notes: state.notes));
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {
                  context.read<NoteBloc>().add(UpdateSortEvent(
                      sortType: 'titleDesc', notes: state.notes));
                },
              ),
            ],
          );
        } else {
          return PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
