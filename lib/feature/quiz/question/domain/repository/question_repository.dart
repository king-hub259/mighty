import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class QuestionRepository{
  final ApiClient apiClient;
  QuestionRepository({required this.apiClient});


  Future<Response?> getQuestionList( int topicId) async {
    return await apiClient.getData("${AppConstants.questions}/$topicId");
  }

  Future<Response?> createQuestion(QuestionBody questionBody) async {
    return await apiClient.postData(AppConstants.questions, questionBody.toJson());
  }

  Future<Response?> updateQuestion(QuestionBody questionBody, int id) async {
    return await apiClient.putData("${AppConstants.questions}/$id", questionBody.toJson());
  }
  

  Future<Response?> deleteQuestion (int id) async {
    return await apiClient.deleteData("${AppConstants.questions}/$id");
  }
}