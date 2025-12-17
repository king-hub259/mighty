import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AcademicImageRepository {
  final ApiClient apiClient;

  AcademicImageRepository({required this.apiClient});
  
  Future<Response?> getAcademicImage(int page) async {
    return await apiClient.getData("${AppConstants.academicImages}?page=$page");
  }

  Future<Response?> createAcademicImage(String title, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.academicImages, {
      "title": title,
    },[], MultipartBody("image", file), []);
  }

  Future<Response?> editAcademicImage(String title, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.academicImages}/$id", {
      "title": title,
      "_method": "put",
    },[], MultipartBody("image", file), []);
  }

  Future<Response?> deleteAcademicImage(int id) async {
    return await apiClient.deleteData("${AppConstants.academicImages}/$id");
  }
}
  