import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class LayoutAndCertificateRepository {
  final ApiClient apiClient;
  LayoutAndCertificateRepository({required this.apiClient});


  Future<Response> getLayoutAndCertificate(String type, int classId, int sectionId, String roll) async {
    return await apiClient.getData("${AppConstants.layoutAndCertificate}?type=$type&class_id=$classId&section_id=$sectionId&roll=$roll");
  }
}