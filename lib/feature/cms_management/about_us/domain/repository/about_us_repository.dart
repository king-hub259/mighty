import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/model/about_us_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class AboutUsRepository {
  final ApiClient apiClient;

  AboutUsRepository({required this.apiClient});
  
  Future<Response?> getAboutUs(int page) async {
    return await apiClient.getData("${AppConstants.aboutUs}?page=$page");
  }

  Future<Response?> createAboutUs(AboutUsBody body, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.aboutUs, body.toJson(), [], MultipartBody("image", file), []);
  }

  Future<Response?> editAboutUs(AboutUsBody body, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.aboutUs}/$id", body.toJson(), [], MultipartBody("image", file), []);
  }


  Future<Response?> deleteAboutUs(int id) async {
    return await apiClient.deleteData("${AppConstants.aboutUs}/$id");
  }
}
  