import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class QuizTopicRepository{
  final ApiClient apiClient;
  QuizTopicRepository({required this.apiClient});


  Future<Response?> getQuizTopicList(int page) async {
    return await apiClient.getData("${AppConstants.topics}?page=$page&perPage=10");
  }

  Future<Response?> createQuizTopic(QuizTopicBody quizTopicBody) async {
    return await apiClient.postData(AppConstants.topics, quizTopicBody.toJson());
  }

  Future<Response?> updateQuizTopic(QuizTopicBody quizTopicBody, int id) async {
    return await apiClient.putData("${AppConstants.topics}/$id", quizTopicBody.toJson());
  }
  

  Future<Response?> deleteQuizTopic (int id) async {
    return await apiClient.deleteData("${AppConstants.topics}/$id");
  }
}