import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddModifyNotePage extends StatelessWidget {
  final Note? note;
  const AddModifyNotePage({super.key, this.note});

  String _getDateTime() {
    final dateTime = DateTime.now();
    final dateFormat = DateFormat.yMd();
    final newDate = dateFormat.format(dateTime);
    return newDate;
  }

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
        context.pop();
      } else if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note == null) {
        context.pop();
      } else if (note != null) {
        note!.title = titleController.text.trim();
        note!.content = contentController.text.trim();
        note!.date = _getDateTime();
        action.add(UpdateNoteEvent(note!));
        action.add(const GetAllNotesEvent());
        context.pop();
      } else {
        final newNote = Note(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          date: _getDateTime(),
        );
        action.add(InsertNoteEvent(newNote));
        action.add(const GetAllNotesEvent());
        context.pop();
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
