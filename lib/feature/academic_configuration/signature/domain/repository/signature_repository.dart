import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class SignatureRepository{
  final ApiClient apiClient;
  SignatureRepository({required this.apiClient});


  Future<Response?> getSignatureList(int page) async {
    return await apiClient.getData("${AppConstants.signature}?page=$page&perPage=10");
  }

  Future<Response?> createNewSignature(String placeAt, String title, XFile? file) async {
    Map<String, String> fields = <String, String> {'place_at': placeAt, 'title': title};
    return await apiClient.postMultipartData(AppConstants.signature, fields, [], MultipartBody("image", file), []);
  }

  Future<Response?> updateSignature(String placeAt, String title, XFile? file, int id) async {
    Map<String, String> fields = <String, String> {
      'place_at': placeAt, 'title': title,
      '_method' : "PUT"
    };
    return await apiClient.putData("${AppConstants.signature}/$id", fields);
  }
  

  Future<Response?> deleteSignature (int id) async {
    return await apiClient.deleteData("${AppConstants.signature}/$id");
  }
}