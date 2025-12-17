import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ParentExamRepository{
  final ApiClient apiClient;
  ParentExamRepository({required this.apiClient});

  Future<Response?> examList() async {
    return await apiClient.getData(AppConstants.parentExam);
  }

  Future<Response?> getExamResults(int examId) async {
    return await apiClient.postData(AppConstants.childrenExamResults, {"exam_id": examId});
  }


}