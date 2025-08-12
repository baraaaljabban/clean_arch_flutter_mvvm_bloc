import 'package:equatable/equatable.dart';

import '../../data/models/question_model.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object?> get props => <Object?>[];
}

class QuestionsInitial extends QuestionsState {
  const QuestionsInitial();
}

class QuestionsLoading extends QuestionsState {
  const QuestionsLoading();
}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  const QuestionsLoaded({required this.questions});

  @override
  List<Object?> get props => <Object?>[questions];
}

class QuestionsError extends QuestionsState {
  final String message;
  const QuestionsError({required this.message});

  @override
  List<Object?> get props => <Object?>[message];
}
