import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class UpdateNotePage extends StatelessWidget {
  final Note note;
  const UpdateNotePage(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final descriptionController = TextEditingController(text: note.description);
    final action = context.read<NoteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyNotes'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          action.add(UpdateNoteEvent(
              note: note,
              title: titleController.text,
              description: descriptionController.text));
          action.add(const GetNotesEvent());
          context.pop();
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          action.add(UpdateNoteEvent(
              note: note,
              title: titleController.text,
              description: descriptionController.text));
          action.add(const GetNotesEvent());
          return true;
        },
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge!.color),
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge!.color),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
