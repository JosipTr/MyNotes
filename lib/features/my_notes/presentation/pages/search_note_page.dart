import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/strings/string.dart';
import '../bloc/note_event.dart';
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
        context.read<NoteBloc>().add(const GetNotesEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Theme.of(context).cardColor,
            style: TextStyle(color: Theme.of(context).cardColor),
            autofocus: true,
            controller: searchController,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is Loaded) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      onLongPress: () {},
                      onTap: () {
                        context.go(addNotePageRoute, extra: state.notes[index]);
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
