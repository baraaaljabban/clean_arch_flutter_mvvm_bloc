import '../../features/questions/data/datasources/question_local_data_source.dart';
import '../../features/questions/data/datasources/question_remote_data_source.dart';
import '../../features/questions/data/repositories/questions_repository_impl.dart';
import '../../features/questions/ui/usecases/get_question.dart';
import '../../features/questions/ui/usecases/get_questions.dart';
import 'dependencies.dart';

void registerQuestionsDep() {
  // Data sources
  sl.registerLazySingleton<QuestionRemoteDataSource>(() => QuestionRemoteDataSource(dioClient: sl()));
  sl.registerLazySingleton<QuestionLocalDataSource>(() => QuestionLocalDataSource());

  // Repository
  sl.registerLazySingleton<QuestionsRepository>(() => QuestionsRepository());

  // Use cases
  sl.registerFactory<GetQuestions>(() => GetQuestions());
  sl.registerFactory<GetQuestion>(() => GetQuestion());
}
