import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class MarkInputRepository{
  final ApiClient apiClient;
  MarkInputRepository({required this.apiClient});



  Future<Response?> getMarkInput(int classId, int examId, int groupId, int subjectId) async {
    return await apiClient.getData("${AppConstants.getMarkInput}$classId?exam_id=$examId&group_id=$groupId&subject_id=$subjectId");
  }
}