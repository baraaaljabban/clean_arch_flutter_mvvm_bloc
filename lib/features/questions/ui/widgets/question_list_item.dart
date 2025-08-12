import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';

class QuestionListItem extends StatelessWidget {
  final Question question;
  final VoidCallback? onTap;
  const QuestionListItem({super.key, required this.question, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(question.title),
      subtitle: Text('User #${question.userId}'),
      onTap: onTap,
    );
  }
}
