import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class MobileAppRepository {
  final ApiClient apiClient;

  MobileAppRepository({required this.apiClient});
  
  Future<Response?> getMobileApp(int page) async {
    return await apiClient.getData("${AppConstants.mobileAppSection}?page=$page");
  }

  Future<Response?> createMobileApp(MobileAppBody body, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.mobileAppSection, body.toJson(),
        [], MultipartBody("image", file),[]);
  }

  Future<Response?> editMobileApp(MobileAppBody body, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.mobileAppSection}/$id", body.toJson(),
        [], MultipartBody("image", file),[]);
  }

  Future<Response?> deleteMobileApp(int id) async {
    return await apiClient.deleteData("${AppConstants.mobileAppSection}/$id");
  }
}
  