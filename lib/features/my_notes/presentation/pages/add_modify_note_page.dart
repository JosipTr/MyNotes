import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/get_datetime.dart';
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
      if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note != null) {
        action.add(RemoveNoteEvent(note!));
        action.add(const GetAllNotesEvent());
      } else if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note == null) {
      } else if (note != null) {
        note!.title = titleController.text.trim();
        note!.content = contentController.text.trim();
        note!.date = getDateTime();
        action.add(UpdateNoteEvent(note!));
        action.add(const GetAllNotesEvent());
      } else {
        final newNote = Note(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          date: getDateTime(),
        );
        action.add(InsertNoteEvent(newNote));
        action.add(const GetAllNotesEvent());
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
        : TextEditingController(text: note!.content);
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
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: 'Content',
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
