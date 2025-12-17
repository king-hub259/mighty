import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class SmsTemplateRepository{
  final ApiClient apiClient;
  SmsTemplateRepository({required this.apiClient});


  Future<Response?> getSmsTemplateList() async {
    return await apiClient.getData(AppConstants.smsTemplate);
  }

  Future<Response?> createSmsTemplate( String name, String description) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.postData(AppConstants.smsTemplate, fields);
  }

  Future<Response?> updateSmsTemplate( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.putData("${AppConstants.smsTemplate}/$id", fields);
  }
  

  Future<Response?> deleteDepartment (int id) async {
    return await apiClient.deleteData("${AppConstants.smsTemplate}/$id");
  }
}