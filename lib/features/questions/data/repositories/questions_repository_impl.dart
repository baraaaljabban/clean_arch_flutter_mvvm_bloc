import 'package:dartz/dartz.dart';

import '../../../../core/dependency_registrar/dependencies.dart';
import '../../../../core/errors/failures.dart';
import '../models/question_model.dart';
import '../datasources/question_remote_data_source.dart';
import '../datasources/question_local_data_source.dart';

class QuestionsRepository {
  //do this 
  final QuestionRemoteDataSource remoteDataSource =sl();
  final QuestionLocalDataSource localDataSource =sl();

  //or you can do this
  // final QuestionRemoteDataSource remoteDataSource;
  // final QuestionLocalDataSource localDataSource;
  // const QuestionsRepository({required this.remoteDataSource, required this.localDataSource});

  Future<Either<Failure, List<Question>>> getQuestions() async {
    try {
      final List<Question> questions = await remoteDataSource.getQuestions();
      await localDataSource.saveLastRefresh(DateTime.now());
      return Right<Failure, List<Question>>(questions);
    } on Exception catch (e) {
      return Left<Failure, List<Question>>(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Question>> getQuestionById(int id) async {
    try {
      final Question question = await remoteDataSource.getQuestionById(id);
      await localDataSource.saveLastRefresh(DateTime.now());
      return Right<Failure, Question>(question);
    } on Exception catch (e) {
      return Left<Failure, Question>(ServerFailure(message: e.toString()));
    }
  }
}
