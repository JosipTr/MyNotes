import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/enums/get_notes_criteria.dart';
import 'package:flutter_notes/core/enums/update_notes_criteria.dart';
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Empty Trash'),
                onTap: () {
                  context.read<NoteBloc>().add(const RemoveNotesEvent());
                },
              ),
            ],
          ),
        ],
      ),
      drawer: const Menu(),
      body: WillPopScope(
        onWillPop: () async {
          context.read<NoteBloc>().add(const GetNotesEvent());
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
                        context.read<NoteBloc>().add(UpdateNotesEvent(
                            criteria: UpdateNotesCriteria.select,
                            id: state.notes[index].id));
                        context.read<NoteBloc>().add(const GetNotesEvent(
                            criteria: GetNotesCriteria.selectedDeleted));
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
                          context
                              .read<NoteBloc>()
                              .add(const RemoveNotesEvent());
                          context.read<NoteBloc>().add(const GetNotesEvent(
                              criteria: GetNotesCriteria.deleted));
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
