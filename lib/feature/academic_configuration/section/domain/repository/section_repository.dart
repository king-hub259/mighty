import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class SectionRepository{
  final ApiClient apiClient;
  SectionRepository({required this.apiClient});

  Future<Response?> getSectionList(int page, int classId) async {
    return await apiClient.getData("${AppConstants.section}?per_page=20&page=$page&class_id=$classId");
  }
  Future<Response?> classWiseSectionList(int id) async {
    return await apiClient.getData("${AppConstants.classWiseSection}/$id");
  }


  Future<Response?> addNewSection(SectionBody sectionBody) async {
    return await apiClient.postData(AppConstants.section, sectionBody.toJson());
  }

  Future<Response?> sectionDetails(int id) async {
    return await apiClient.getData("${AppConstants.section}/$id");
  }

  Future<Response?> sectionEdit(SectionBody sectionBody, int id) async {
    return await apiClient.postData("${AppConstants.section}/$id", sectionBody.toJson());
  }

  Future<Response?> sectionDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.section}/$id");
  }
}