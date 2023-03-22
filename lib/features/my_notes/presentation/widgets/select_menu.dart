import 'package:flutter/material.dart';

class SelectMenu extends StatelessWidget {
  const SelectMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Select all'),
          onTap: () {},
        ),
      ],
    );
  }
}
