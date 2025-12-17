import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class ReadyToJoinRepository {
  final ApiClient apiClient;

  ReadyToJoinRepository({required this.apiClient});
  
  Future<Response?> getReadyToJoin(int page) async {
    return await apiClient.getData("${AppConstants.readyToJoin}?page=$page");
  }

  Future<Response?> createReadyToJoin(ReadyToJoinBody body, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.readyToJoin,
        body.toJson(), [], MultipartBody("icon", file),[]);
  }

  Future<Response?> editReadyToJoin(ReadyToJoinBody body, XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.readyToJoin}/$id",
        body.toJson(), [], MultipartBody("icon", file),[]);
  }

  Future<Response?> deleteReadyToJoin(int id) async {
    return await apiClient.deleteData("${AppConstants.readyToJoin}/$id");
  }
}
  