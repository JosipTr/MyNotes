import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        Navigator.of(context).pop();
      } else if (titleController.text.isEmpty &&
          contentController.text.isEmpty &&
          note == null) {
        Navigator.of(context).pop();
      } else if (note != null) {
        final dateTime = DateTime.now();
        final dateFormat = DateFormat.yMd();
        final newDate = dateFormat.format(dateTime);
        note!.title = titleController.text.trim();
        note!.content = contentController.text.trim();
        note!.date = newDate;
        action.add(UpdateNoteEvent(note!));
        action.add(const GetAllNotesEvent());
        Navigator.of(context).pop();
      } else {
        var dateTime = DateTime.now();
        var dateFormat = DateFormat.yMd();
        var newDate = dateFormat.format(dateTime);
        print(newDate);
        final newNote = Note(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          date: newDate,
        );
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
          margin: const EdgeInsets.all(20),
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
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
