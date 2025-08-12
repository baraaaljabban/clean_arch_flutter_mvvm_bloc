import 'package:dartz/dartz.dart';

import '../../../../../core/dependency_registrar/dependencies.dart';
import '../../../../core/base_use_cases.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/questions_repository_impl.dart';

class GetQuestions extends UseCase<List<Question>, NoParams> {
  final QuestionsRepository repository = sl();
  //or
  // final QuestionsRepository repository;

  // const GetQuestions({required this.repository});

  @override
  Future<Either<Failure, List<Question>>> call(NoParams params) {
    return repository.getQuestions();
  }
}
