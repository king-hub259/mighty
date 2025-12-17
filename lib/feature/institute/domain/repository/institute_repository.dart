import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_body_model.dart';
import 'package:mighty_school/util/app_constants.dart';

class InstituteRepository{
  final ApiClient apiClient;
  InstituteRepository({required this.apiClient});


  Future<Response?> getInstituteList(int page) async {
    return await apiClient.getData("${AppConstants.institutes}?page=$page&perPage=10");
  }

  Future<Response?> pendingInstituteList(int page) async {
    return await apiClient.getData("${AppConstants.onboardingsList}?page=$page&perPage=10");
  }

  Future<Response?> applyInstitute(InstituteBodyModel body, XFile? logo, XFile? avatar) async {
    return await apiClient.postMultipartData(AppConstants.applyInstitute, body.toJson(),[MultipartBody("user_avatar", avatar)],MultipartBody("institute_logo", logo),[]);
  }

  Future<Response?> subscriptionPlanUpdate(int planId, int instituteId) async {
    return await apiClient.postData(AppConstants.subscriptionPlanUpdate,{
      "plan_id": planId,
      "institute_id": instituteId,
    });
  }

  Future<Response?> approveInstituteRequest (int id) async {
    return await apiClient.getData("${AppConstants.onboardingsApprove}/$id");
  }


}