import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesSubHeadRepository{
  final ApiClient apiClient;
  FeesSubHeadRepository({required this.apiClient});

  Future<Response?> getFeesSubHeadList(int page) async {
    return await apiClient.getData("${AppConstants.feesSubHead}?per_page=20&page=$page");
  }

  Future<Response?> addNewFessSubHead(String name, String serial) async {
    return await apiClient.postData(AppConstants.feesSubHead, {"name": name, "serial" : serial});
  }

  Future<Response?> editFessSubHead(String name, String serial, int id) async {
    return await apiClient.postData("${AppConstants.feesSubHead}/$id", {"name": name, "serial" : serial});
  }

  Future<Response?> deleteFeesSubHead(int id) async {
    return await apiClient.deleteData("${AppConstants.feesSubHeadDelete}$id");
  }
}