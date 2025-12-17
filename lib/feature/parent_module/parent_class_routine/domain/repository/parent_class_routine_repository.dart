import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:get/get.dart' as get_type;

class ParentClassRoutineRepository{
  final ApiClient apiClient;
  ParentClassRoutineRepository({required this.apiClient});


  Future<Response?> getClassRoutine() async {
    final String? userType = get_type.Get.find<ProfileController>().profileModel?.data?.role;
    if(userType == AppConstants.parent){
      return await apiClient.getData(AppConstants.parentClassRoutine);}
    else {
      return await apiClient.getData(AppConstants.studentClassRoutine);
    }
  }

}