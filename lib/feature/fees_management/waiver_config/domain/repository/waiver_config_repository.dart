import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class WaiverConfigRepository{
  final ApiClient apiClient;
  WaiverConfigRepository({required this.apiClient});

  Future<Response?> getWaiverAssignListList(int page) async {
    return await apiClient.getData("${AppConstants.waiver}?per_page=20&page=$page");
  }

  Future<Response?> addNewWaiver(String name) async {
    return await apiClient.postData(AppConstants.waiver, {"waiver": name});
  }

  Future<Response?> editWaiver(String name, int id) async {
    return await apiClient.postData("${AppConstants.waiver}/$id", {"name": name});
  }

  Future<Response?> deleteWaiver(int id) async {
    return await apiClient.deleteData("${AppConstants.waiverDelete}$id");
  }
}