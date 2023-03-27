import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final action = context.read<NoteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyNotes'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          action.add(InsertNoteEvent(
              title: titleController.text,
              description: descriptionController.text));
          context.pop();
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          action.add(InsertNoteEvent(
              title: titleController.text,
              description: descriptionController.text));
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
