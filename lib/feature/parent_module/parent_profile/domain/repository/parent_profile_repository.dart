import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ParentProfileRepository{
  final ApiClient apiClient;
  ParentProfileRepository({required this.apiClient});


  Future<Response?> getProfileInfo() async {
    return await apiClient.getData(AppConstants.parentProfile);
  }

  Future<Response?> getDashboardData() async {
    return await apiClient.getData(AppConstants.parentDashboardData);
  }

}