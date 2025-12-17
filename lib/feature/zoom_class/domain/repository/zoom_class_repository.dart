import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/zoom_class/domain/model/zoom_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class ZoomClassRepository {
  final ApiClient apiClient;

  ZoomClassRepository({required this.apiClient});
  
  Future<Response?> getZoomClass(int page) async {
    return await apiClient.getData("${AppConstants.zooms}?per_page=10&page=$page");
  }

  Future<Response?> createZoomClass(ZoomBody body) async {
    return await apiClient.postData(AppConstants.zooms, body.toJson());
  }

  Future<Response?> editZoomClass(ZoomBody body, int id) async {
    return await apiClient.postData("${AppConstants.zooms}/$id", body.toJson());
  }

  Future<Response?> deleteZoomClass(int id) async {
    return await apiClient.deleteData("${AppConstants.zooms}/$id");
  }

  Future<Response?> updateZoomClassConfig(String zoomAccountId, String zoomClientKey, String zoomClientSecret) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "zoom_account_id": zoomAccountId,
      "zoom_client_key": zoomClientKey,
      "zoom_client_secret": zoomClientSecret
    });
  }
}
  