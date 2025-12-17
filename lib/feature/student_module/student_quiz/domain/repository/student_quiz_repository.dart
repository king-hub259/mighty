import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';
class StudentQuizRepository{
  final ApiClient apiClient;
  StudentQuizRepository({required this.apiClient});


  Future<Response?> getQuizList() async {
    return await apiClient.getData(AppConstants.studentQuiz);
  }

  Future<Response?> getQuizDetails(int id) async {
    return await apiClient.getData("${AppConstants.studentQuiz}/$id");
  }


}