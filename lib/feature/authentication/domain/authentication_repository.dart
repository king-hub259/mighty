import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AuthenticationRepository{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthenticationRepository( {required this.apiClient, required this.sharedPreferences,});

  Future<Response?> login({required String email, required String password}) async {
    return await apiClient.postData(AppConstants.loginUri,
        {"email": email, "password": password});
  }
  Future<bool?> saveUserToken(String token) async {
    apiClient.updateHeader(token, null);
    return await sharedPreferences.setString(AppConstants.token, token);

  }


  Future<bool?> setUSerTypeParent(String type) async {
    return await sharedPreferences.setString(AppConstants.userType, type);
  }

  String getUserType() {
    return sharedPreferences.getString(AppConstants.userType) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<void> saveEmailAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userNumber, number);

    } catch (e) {
      rethrow;
    }
  }
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    return true;
  }

}