import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/get_datetime.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddModifyNotePage extends StatelessWidget {
  final Note? note;
  const AddModifyNotePage({super.key, this.note});

  void _addNote(TextEditingController titleController,
      TextEditingController contentController, NoteBloc action) {
    {
      if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note != null) {
        action.add(const GetNotesEvent());
      } else if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note == null) {
        action.add(const GetNotesEvent());
      } else if (note != null &&
          note!.title == titleController.text &&
          note!.content == contentController.text) {
        action.add(const GetNotesEvent());
      } else if (note != null) {
        final title = titleController.text.trim();
        final content = contentController.text.trim();
        final date = getDateTime();
        action.add(UpdateNotesEvent(
            note: Note(
                id: note!.id, title: title, content: content, date: date)));
        action.add(const GetNotesEvent());
      } else {
        final newNote = Note(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          date: getDateTime(),
        );
        action.add(InsertNoteEvent(newNote));
        action.add(const GetNotesEvent());
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          _addNote(titleController, contentController, action);
          context.pop();
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          _addNote(titleController, contentController, action);
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
                  controller: contentController,
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
