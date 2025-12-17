import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class AssignmentRepository{
  final ApiClient apiClient;
  AssignmentRepository({required this.apiClient});


  Future<Response?> getAssignmentList(int page) async {
    return await apiClient.getData("${AppConstants.assignment}?page=$page&per_page=10");
  }

  Future<Response?> createNewAssignment( AssignmentBody assignmentBody , List<MultipartDocument> attachments) async {
    return await apiClient.postMultipartData(AppConstants.assignment, assignmentBody.toJson(), [], null, attachments);
  }

  Future<Response?> updateAssignment( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.putData("${AppConstants.assignment}/$id", fields);
  }
  

  Future<Response?> deleteAssignment (int id) async {
    return await apiClient.deleteData("${AppConstants.assignment}/$id");
  }
}