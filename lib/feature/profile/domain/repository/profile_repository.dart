import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ProfileRepository{
  final ApiClient apiClient;
  ProfileRepository({required this.apiClient});


  Future<Response?> getProfileInfo() async {
    return await apiClient.getData(AppConstants.profile);
  }

  Future<Response?> updateProfile(String name, String email) async {
    return await apiClient.postData(AppConstants.updateProfile, {
      'name': name,
      'email': email,
    });
  }

  Future<Response?> changePassword(String oldPassword, String newPassword) async {
    return await apiClient.postData(AppConstants.changePassword, {
      'current_password': oldPassword,
      'password': newPassword,
      'password_confirmation': newPassword,
    });
  }

}