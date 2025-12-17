import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ShiftRepository{
  final ApiClient apiClient;
  ShiftRepository({required this.apiClient});


  Future<Response?> getShiftList() async {
    return await apiClient.getData(AppConstants.shift);
  }

  Future<Response?> createNewShift( String name) async {
    Map<String, String> fields = <String, String> {'name': name};

    return await apiClient.postData(AppConstants.shift, fields);
  }

  Future<Response?> updateShift( String name, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,

    };
    return await apiClient.putData("${AppConstants.shift}/$id", fields);
  }
  

  Future<Response?> deleteShift (int id) async {
    return await apiClient.deleteData("${AppConstants.shift}/$id");
  }
}