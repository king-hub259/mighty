import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesManagementRepository{
  final ApiClient apiClient;
  FeesManagementRepository({required this.apiClient});




  Future<Response?> getStudentQuickCollectionSearch(int classId, int sectionId, int page) async {
    return await apiClient.getData("${AppConstants.quickCollection}?class_id=$classId&section_id=$sectionId&per_page=20&page=$page");
  }

  Future<Response?> getStudentQuickCollection(int id) async {
    return await apiClient.getData("${AppConstants.quickCollection}/$id");
  }


  Future<Response?> smartCollection(int id) async {
    return await apiClient.postData(AppConstants.quickCollection,{

    });
  }

}