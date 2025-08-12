import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/base_use_cases.dart';
import '../../../../core/dependency_registrar/dependencies.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/question_model.dart';
import '../usecases/get_questions.dart';
import 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final GetQuestions getQuestions = sl();

  QuestionsCubit() : super(const QuestionsInitial()) {
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    emit(const QuestionsLoading());
    final Either<Failure, List<Question>> result = await getQuestions(const NoParams());
    result.fold(
      (Failure failure) => emit(QuestionsError(message: failure.message)),
      (List<Question> questions) => emit(QuestionsLoaded(questions: questions)),
    );
  }
}
