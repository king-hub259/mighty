import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/model/exam_routine_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class ExamRoutineRepository{
  final ApiClient apiClient;
  ExamRoutineRepository({required this.apiClient});

  Future<Response?> getExamRoutineList(int classId, int examId) async {
    return await apiClient.getData("${AppConstants.examRoutine}?class_id=1&exam_id=1");
  }



  Future<Response?> storeExamRoutine(ExamRoutineBody body) async {
    return await apiClient.postData(AppConstants.examRoutineStore, body.toJson());
  }

}