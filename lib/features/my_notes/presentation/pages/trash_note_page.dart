import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/empty_list.dart';
import '../widgets/menu.dart';
import 'package:go_router/go_router.dart';
import 'package:nil/nil.dart';

import '../../../../core/constants/strings/string_constants.dart';
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
          IconButton(
              onPressed: () {
                context.pop();
                context.go(StringConstants.searchNotePageRoute);
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Empty Trash'),
                onTap: () {},
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
                    color: state.notes[index].isSelected
                        ? Colors.blueGrey[200]
                        : Theme.of(context).cardColor,
                    child: ListTile(
                      onLongPress: () {
                        context.read<NoteBloc>().add(ToggleNoteSelectEvent(
                            note: state.notes[index], notes: state.notes));
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
                      trailing: IconButton(
                        onPressed: () {
                          context
                              .read<NoteBloc>()
                              .add(RemoveNoteEvent(notes: state.notes));
                          context
                              .read<NoteBloc>()
                              .add(const GetDeletedNotesEvent());
                        },
                        icon: state.notes[index].isSelected
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
              return EmptyList(
                message: state.message,
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
