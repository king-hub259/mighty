import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class SessionRepository{
  final ApiClient apiClient;
  SessionRepository({required this.apiClient});


  Future<Response?> getSessionList(int page) async {
    return await apiClient.getData("${AppConstants.sessions}?page=$page&perPage=10");
  }

  Future<Response?> createNewSession( String session, String year) async {
    Map<String, String> fields = <String, String> {
      'session': session,
      'year': year,
    };

    return await apiClient.postData(AppConstants.sessions, fields);
  }

  Future<Response?> updateSession( String session, String year, int id) async {
    Map<String, String> fields = <String, String> {
      'session': session,
      'year': year,
      '_method' : "PUT"
    };
    return await apiClient.putData("${AppConstants.sessions}/$id", fields);
  }
  

  Future<Response?> deleteSession (int id) async {
    return await apiClient.deleteData("${AppConstants.sessions}/$id");
  }

  Future<Response?> changeSession (int id) async {
    return await apiClient.postData(AppConstants.changeSession,{
      "session_id":id
    });
  }


}