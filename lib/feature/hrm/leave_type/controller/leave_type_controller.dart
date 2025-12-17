import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hrm/leave_type/domain/models/leave_type_model.dart';
import 'package:mighty_school/feature/hrm/leave_type/domain/repository/leave_type_repository.dart';

class LeaveTypeController extends GetxController implements GetxService{
  final LeaveTypeRepository leaveTypeRepository;
  LeaveTypeController({required this.leaveTypeRepository});



  bool isLoading = false;
  LeaveTypeModel? leaveTypeModel;
  Future<void> getLeaveTypeList(int offset) async {
    isLoading = true;
    Response? response = await leaveTypeRepository.getLeaveTypeList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        leaveTypeModel = LeaveTypeModel.fromJson(response?.body);
      }else{
        leaveTypeModel?.data?.data?.addAll(LeaveTypeModel.fromJson(response?.body).data!.data!);
        leaveTypeModel?.data?.currentPage = LeaveTypeModel.fromJson(response?.body).data?.currentPage;
        leaveTypeModel?.data?.total = LeaveTypeModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  Future<void> createNewLeaveType(String name, String description) async {
    isLoading = true;
    update();
    Response? response = await leaveTypeRepository.createNewLeaveType(name, description);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("leave_type_added_successfully".tr, isError: false);
      getLeaveTypeList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateLeaveType(String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await leaveTypeRepository.updateLeaveType(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("leave_type_updated_successfully".tr, isError: false);
      getLeaveTypeList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteLeaveType(int id) async {
    isLoading = true;
    Response? response = await leaveTypeRepository.deleteLeaveType(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("leave_type_deleted_successfully".tr, isError: false);
      getLeaveTypeList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
}