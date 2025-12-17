import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ParentSubjectRepository{
  final ApiClient apiClient;
  ParentSubjectRepository({required this.apiClient});


  Future<Response?> getChildrenSubjects() async {
    return await apiClient.getData(AppConstants.childrenSubjects);
  }


}