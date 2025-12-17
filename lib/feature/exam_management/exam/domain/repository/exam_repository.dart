import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ExamRepository{
  final ApiClient apiClient;
  ExamRepository({required this.apiClient});

  Future<Response?> examList(int page) async {
    return await apiClient.getData("${AppConstants.exam}?per_page=20&page=$page");
  }
  Future<Response?> addNewExam(String name) async {
    return await apiClient.postData(AppConstants.exam, {
      "name": name,

    });
  }



  Future<Response?> examEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.exam}/$id",
        {
          "name": name,
          "_method" : "PUT"
        });
  }

  Future<Response?> deleteExam(int id) async {
    return await apiClient.deleteData("${AppConstants.exam}/$id");
  }
}