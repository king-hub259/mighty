import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class BannerRepository {
  final ApiClient apiClient;

  BannerRepository({required this.apiClient});
  
  Future<Response?> getBanner(int page) async {
    return await apiClient.getData("${AppConstants.banner}?page=$page");
  }

  Future<Response?> createBanner(BannerBody body, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.banner, body.toJson(), [], MultipartBody("image", file),[]);
  }

  Future<Response?> editBanner(BannerBody body, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.banner}/$id", body.toJson(), [], MultipartBody("image", file),[]);
  }

  Future<Response?> deleteBanner(int id) async {
    return await apiClient.deleteData("${AppConstants.banner}/$id");
  }
}
  