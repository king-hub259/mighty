import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class DepartmentRepository{
  final ApiClient apiClient;
  DepartmentRepository({required this.apiClient});


  Future<Response?> getDepartmentList(int page) async {
    return await apiClient.getData("${AppConstants.department}?page=$page&perPage=10");
  }

  Future<Response?> createNewDepartment( String name, String description) async {
    Map<String, String> fields = <String, String> {
      'department_name': name,
      'priority': description,
    };

    return await apiClient.postData(AppConstants.department, fields);
  }

  Future<Response?> updateDepartment( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.putData("${AppConstants.department}/$id", fields);
  }
  

  Future<Response?> deleteDepartment (int id) async {
    return await apiClient.deleteData("${AppConstants.department}/$id");
  }
}