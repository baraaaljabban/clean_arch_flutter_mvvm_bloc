import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';
import 'question_list_item.dart';

class QuestionsList extends StatelessWidget {
  final List<Question> questions;
  const QuestionsList({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        final Question q = questions[index];
        return QuestionListItem(
          question: q,
          onTap: () {},
        );
      },
    );
  }
}
