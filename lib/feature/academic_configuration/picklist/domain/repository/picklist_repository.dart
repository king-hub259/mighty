import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class PickListRepository{
  final ApiClient apiClient;
  PickListRepository({required this.apiClient});


  Future<Response?> getPickList(int page) async {
    return await apiClient.getData("${AppConstants.picklists}?page=$page&perPage=10");
  }

  Future<Response?> createNewPickList( String name, String description) async {
    Map<String, String> fields = <String, String> {
      'type': name,
      'value': description,
    };

    return await apiClient.postData(AppConstants.picklists, fields);
  }

  Future<Response?> updatePickList( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'type': name,
      'value': description,
      '_method' : "PUT"
    };
    return await apiClient.putData("${AppConstants.picklists}/$id", fields);
  }
  

  Future<Response?> deletePickLis (int id) async {
    return await apiClient.deleteData("${AppConstants.picklists}/$id");
  }
}