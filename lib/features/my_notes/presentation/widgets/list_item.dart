import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../pages/add_modify_note_page.dart';

class ListItem extends StatelessWidget {
  final Loaded state;
  const ListItem({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: deviceHeight * 0.9,
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 5,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddModifyNotePage(note: state.notes[index]);
                    },
                  ),
                ),
                leading:
                    CircleAvatar(child: Text(state.notes[index].id.toString())),
                title: Text(
                  state.notes[index].title!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(
                  state.notes[index].content!,
                  maxLines: 2,
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
        ),
      ),
    );
  }
}
