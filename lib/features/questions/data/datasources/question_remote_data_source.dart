import '../../../../core/network/dio_client.dart';
import '../models/question_model.dart';

class QuestionRemoteDataSource {
  final DioClient dioClient;

  const QuestionRemoteDataSource({required this.dioClient});

  Future<List<Question>> getQuestions() async {
    final dynamic response = await dioClient.getData('https://jsonplaceholder.typicode.com/posts');
    final List<dynamic> data = response.data as List<dynamic>;
    final List<Question> result = data.map((dynamic item) => Question.fromMap(item as Map<String, Object?>)).toList();
    return result;
  }

  Future<Question> getQuestionById(int id) async {
    final dynamic response = await dioClient.getData('https://jsonplaceholder.typicode.com/posts/$id');
    final Map<String, Object?> data = response.data as Map<String, Object?>;
    final Question question = Question.fromMap(data);
    return question;
  }
}
