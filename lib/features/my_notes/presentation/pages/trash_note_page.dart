import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/empty_list.dart';
import 'package:flutter_notes/features/my_notes/presentation/widgets/menu.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';

class TrashNotePage extends StatelessWidget {
  const TrashNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
      ),
      drawer: const Menu(),
      body: WillPopScope(
        onWillPop: () async {
          context.read<NoteBloc>().add(const GetAllNotesEvent());
          return true;
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is Loaded) {
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
                        context
                            .read<NoteBloc>()
                            .add(SelectNoteEvent(state.notes[index]));
                        context
                            .read<NoteBloc>()
                            .add(const GetAllSelectedDeletedNotesEvent());
                      },
                      onTap: () {
                        if (state.notes[index].isSelected!) {
                          context
                              .read<NoteBloc>()
                              .add(SelectNoteEvent(state.notes[index]));
                        }
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
                          context
                              .read<NoteBloc>()
                              .add(const RemoveDeletedNotesEvent());
                          context
                              .read<NoteBloc>()
                              .add(const GetAllDeletedNotesEvent());
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
            } else if (state is Empty) {
              return const EmptyList(
                message: 'Trash is empty',
                iconPath: 'assets/images/recycle-bin.png',
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
