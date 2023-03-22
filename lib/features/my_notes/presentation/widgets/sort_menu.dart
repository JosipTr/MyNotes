import 'package:flutter/material.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.sort),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Text('By title', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Text('By date', style: Theme.of(context).textTheme.labelMedium!),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
