import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

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
          const Text(
            'No notes added!',
            style: TextStyle(fontSize: 19),
          )
        ],
      ),
    );
  }
}
