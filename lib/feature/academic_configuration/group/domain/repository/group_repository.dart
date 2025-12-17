import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class GroupRepository{
  final ApiClient apiClient;
  GroupRepository({required this.apiClient});

  Future<Response?> getGroupList(int page) async {
    return await apiClient.getData("${AppConstants.group}?per_page=20&page=$page");
  }
  Future<Response?> addNewGroup(String name) async {
    return await apiClient.postData(AppConstants.group, {
      "group_name": name,

    });
  }



  Future<Response?> groupEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.group}/$id",
        {
          "group_name": name,
          "_method" : "PUT"
        });
  }

  Future<Response?> deleteGroup(int id) async {
    return await apiClient.deleteData("${AppConstants.group}/$id");
  }
}