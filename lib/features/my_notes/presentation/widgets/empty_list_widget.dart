import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  final String iconPath;
  const EmptyListWidget(
      {super.key, required this.message, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 150,
            width: 150,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 19),
          )
        ],
      ),
    );
  }
}
