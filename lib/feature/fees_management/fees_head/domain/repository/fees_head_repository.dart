import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesHeadRepository{
  final ApiClient apiClient;
  FeesHeadRepository({required this.apiClient});

  Future<Response?> getFeesHeadList(int page) async {
    return await apiClient.getData("${AppConstants.feesHead}?per_page=20&page=$page");
  }

  Future<Response?> addNewFessHead(String name, String serial) async {
    return await apiClient.postData(AppConstants.feesHead, {"name": name, "serial" : serial});
  }

  Future<Response?> editFessHead(String name, String serial, int id) async {
    return await apiClient.postData("${AppConstants.feesHead}/$id", {"name": name, "serial" : serial});
  }

  Future<Response?> deleteFeesHead(int id) async {
    return await apiClient.deleteData("${AppConstants.deleteFeesHead}$id");
  }
}