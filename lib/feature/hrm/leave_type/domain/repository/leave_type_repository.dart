import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class LeaveTypeRepository{
  final ApiClient apiClient;
  LeaveTypeRepository({required this.apiClient});


  Future<Response?> getLeaveTypeList(int page) async {
    return await apiClient.getData("${AppConstants.leaveType}?page=$page&perPage=10");
  }

  Future<Response?> createNewLeaveType(String name, String description) async {
    return await apiClient.postData(AppConstants.leaveType, {
      'name': name,
      'description': description,
    });
  }

  Future<Response?> updateLeaveType(String name, String description, int id) async {
    return await apiClient.putData("${AppConstants.leaveType}/$id", {
      'name': name,
      'description': description,
    });
  }
  

  Future<Response?> deleteLeaveType (int id) async {
    return await apiClient.deleteData("${AppConstants.leaveType}/$id");
  }
}