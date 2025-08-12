import 'package:dartz/dartz.dart';
import 'package:clean_arch_flutter_bloc/core/dependency_registrar/dependencies.dart';
import '../../../../core/base_use_cases.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/questions_repository_impl.dart';

class GetQuestion extends UseCase<Question, GetQuestionParams> {
  final QuestionsRepository repository = sl();
//or
  // final QuestionsRepository repository;
  // const GetQuestion({required this.repository});

  @override
  Future<Either<Failure, Question>> call(GetQuestionParams params) {
    return repository.getQuestionById(params.id);
  }
}

class GetQuestionParams {
  final int id;
  const GetQuestionParams({required this.id});
}
