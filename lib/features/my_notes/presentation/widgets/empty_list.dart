import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String message;
  const EmptyList({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/post-it.png',
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
