import 'package:flutter/material.dart';

class QuestionsErrorView extends StatelessWidget {
  final String message;
  const QuestionsErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
