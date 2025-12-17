import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class RoleRepository{
  final ApiClient apiClient;
  RoleRepository({required this.apiClient});


  Future<Response?> getRoleList(int page) async {
    return await apiClient.getData("${AppConstants.role}?page=$page&perPage=10");
  }

  Future<Response?> getPermissionList() async {
    return await apiClient.getData(AppConstants.permissionList);
  }

  Future<Response?> createNewRole(RoleBody roleBody) async {
    return await apiClient.postData(AppConstants.role, roleBody.toJson());
  }

  Future<Response?> updateRole(RoleBody roleBody, int id) async {
    return await apiClient.putData("${AppConstants.role}/$id", roleBody.toJson());
  }



  Future<Response?> deleteRole (int id) async {
    return await apiClient.deleteData("${AppConstants.role}/$id");
  }
}