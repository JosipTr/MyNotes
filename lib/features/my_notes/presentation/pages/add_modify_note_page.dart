import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddModifyNotePage extends StatelessWidget {
  final Note? note;
  const AddModifyNotePage({super.key, this.note});

  void _addNote(
      TextEditingController titleController,
      TextEditingController contentController,
      BuildContext context,
      NoteBloc action) {
    {
      if (titleController.text.isEmpty && contentController.text.isEmpty) {
        Navigator.of(context).pop();
      } else {
        final newNote = Note(
            title: titleController.text.trim(),
            content: contentController.text.trim());
        action.add(RemoveNoteEvent(note!));
        action.add(InsertNoteEvent(newNote));
        action.add(const GetAllNotesEvent());
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleController = note == null
        ? TextEditingController()
        : TextEditingController(text: note!.title);
    final contentController = note == null
        ? TextEditingController()
        : TextEditingController(text: note!.title);
    final action = context.read<NoteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyNotes'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          _addNote(titleController, contentController, context, action);
          return true;
        },
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'Content',
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  _addNote(titleController, contentController, context, action),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
