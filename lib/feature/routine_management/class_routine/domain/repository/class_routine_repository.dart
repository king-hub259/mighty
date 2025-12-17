import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ClassRoutineRepository{
  final ApiClient apiClient;
  ClassRoutineRepository({required this.apiClient});


  Future<Response?> getClassRoutine(int classId, int sectionId) async {
    return await apiClient.getData("${AppConstants.classRoutine}?class_id=$classId&section_id=$sectionId");
  }

}