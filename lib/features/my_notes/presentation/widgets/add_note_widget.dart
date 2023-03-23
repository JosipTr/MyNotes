import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/strings/string_constants.dart';

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: FloatingActionButton(
        child: const Icon(
          Icons.note_add,
        ),
        onPressed: () => context.go(StringConstants.addNotePageRoute),
      ),
    );
  }
}
