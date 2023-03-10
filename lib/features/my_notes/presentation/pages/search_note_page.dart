import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/strings/string.dart';
import 'package:flutter_notes/features/my_notes/presentation/bloc/note_event.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';

class SearchNotePage extends StatelessWidget {
  const SearchNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        context.read<NoteBloc>().add(const GetAllNotesEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Theme.of(context).cardColor,
            style: TextStyle(color: Theme.of(context).cardColor),
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              context
                  .read<NoteBloc>()
                  .add(SearchNoteEvent(searchController.text));
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is SearchNoteLoaded) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      onLongPress: () {
                        context
                            .read<NoteBloc>()
                            .add(SelectNoteEvent(state.notes[index]));
                        context
                            .read<NoteBloc>()
                            .add(SearchNoteEvent(searchController.text));
                      },
                      onTap: () {
                        if (state.notes[index].isSelected!) {
                          context
                              .read<NoteBloc>()
                              .add(SelectNoteEvent(state.notes[index]));
                        }
                        context.go(addNotePageRoute, extra: state.notes[index]);
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
                    ),
                  );
                },
              );
            } else if (state is Empty) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
