import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class WhyChooseUsRepository {
  final ApiClient apiClient;

  WhyChooseUsRepository({required this.apiClient});
  
  Future<Response?> getWhyChooseUs(int page) async {
    return await apiClient.getData("${AppConstants.whyChooseUs}?page=$page");
  }

  Future<Response?> createWhyChooseUs(String title, String description, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.whyChooseUs,{
      "title": title,
      "description": description,
    },[], MultipartBody("icon", file), []);
  }

  Future<Response?> editWhyChooseUs(String title, String description, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.whyChooseUs}/$id",
        {
          "title": title,
          "description": description,
          "_method": "put"
        },
        [], MultipartBody("icon", file), []);
  }



  Future<Response?> deleteWhyChooseUs(int id) async {
    return await apiClient.deleteData("${AppConstants.whyChooseUs}/$id");
  }
}
  