import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/questions_cubit.dart';
import '../cubit/questions_state.dart';
import '../widgets/questions_loader.dart';
import '../widgets/questions_error.dart';
import '../widgets/questions_list.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions')),
      body: BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (BuildContext context, QuestionsState state) {
          if (state is QuestionsLoading) {
            return const QuestionsLoader();
          }
          if (state is QuestionsError) {
            return QuestionsErrorView(message: state.message);
          }
          if (state is QuestionsLoaded) {
            return QuestionsList(questions: state.questions);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
