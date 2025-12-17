import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:get/get.dart' as get_package;


class ParentEventRepository{
  final ApiClient apiClient;
  ParentEventRepository({required this.apiClient});


  Future<Response?> getEventList(int page) async {
    final String? userType =  get_package.Get.find<ProfileController>().profileModel?.data?.role;
    if(userType == AppConstants.parent){
      return await apiClient.getData("${AppConstants.childrenStudentEvents}?page=$page&perPage=10");
    }else{
      return await apiClient.getData("${AppConstants.studentEvent}?page=$page&perPage=10");
    }
  }

}