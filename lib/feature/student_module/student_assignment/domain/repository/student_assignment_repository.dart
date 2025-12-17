import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/models/student_assignment_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class StudentAssignmentRepository{
  final ApiClient apiClient;
  StudentAssignmentRepository({required this.apiClient});


  Future<Response?> getMyAssignmentList(int page) async {
    return await apiClient.getData("${AppConstants.studentAssignment}?page=$page&per_page=10");
  }

  Future<Response?> getMyAssignmentDetails(int id) async {
    return await apiClient.getData("${AppConstants.studentAssignment}/$id");
  }

  Future<Response?> createNewAssignment( StudentAssignmentBody assignmentBody , List<MultipartDocument> attachments) async {
    return await apiClient.postMultipartData(AppConstants.studentAssignment, assignmentBody.toJson(), [], null, attachments);
  }

  Future<Response?> updateAssignment( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.putData("${AppConstants.studentAssignment}/$id", fields);
  }
  


}