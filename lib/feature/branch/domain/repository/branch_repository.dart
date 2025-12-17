import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class BranchRepository{
  final ApiClient apiClient;
  BranchRepository({required this.apiClient});


  Future<Response?> getBranchList(int page) async {
    return await apiClient.getData("${AppConstants.branches}?page=$page&perPage=10");
  }

  Future<Response?> createNewBranch( String name) async {
    Map<String, String> fields = <String, String> {
      'name': name,
    };

    return await apiClient.postData(AppConstants.branches, fields);
  }

  Future<Response?> updateBranch( String name, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      '_method' : "PUT"
    };
    return await apiClient.putData("${AppConstants.branches}/$id", fields);
  }
  

  Future<Response?> deleteBranch (int id) async {
    return await apiClient.deleteData("${AppConstants.branches}/$id");
  }

  Future<Response?> changeBranch (int id) async {
    return await apiClient.postData(AppConstants.changeBranches, {
      "branch_id": id
    });
  }

}