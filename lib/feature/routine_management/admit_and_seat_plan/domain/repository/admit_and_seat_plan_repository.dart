import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AdmitAndSeatPlanRepository{
  final ApiClient apiClient;
  AdmitAndSeatPlanRepository({required this.apiClient});

  Future<Response?> getSeatPlatAndAdmit(int classId, int examId, int sectionId, String type) async {
    return await apiClient.getData("${AppConstants.examEssentials}?class_id=$classId&exam_id=$examId&section_id=$sectionId&type=$type");
  }
}