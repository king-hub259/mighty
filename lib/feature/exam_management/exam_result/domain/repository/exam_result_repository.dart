import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ExamResultRepository{
  final ApiClient apiClient;
  ExamResultRepository({required this.apiClient});

  Future<Response?> getExamResult(int classId, int groupId, int subjectId, int studentId) async {
    return await apiClient.getData("${AppConstants.examResult}?class_id=$classId&group_id=$groupId&subject_id=$subjectId&student_id=$studentId");
  }
}