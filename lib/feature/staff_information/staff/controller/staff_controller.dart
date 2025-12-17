
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/models/staff_details_model.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/models/staff_model.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/repository/staff_repository.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_body.dart';


class StaffController extends GetxController implements GetxService{
  final StaffRepository staffRepository;
  StaffController({required this.staffRepository});

  StaffModel? staffModel;
  Future<void> getStaffList(int page) async {
    Response? response = await staffRepository.getStaffList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        staffModel = StaffModel.fromJson(response?.body);
      }else{
        staffModel?.data?.data?.addAll(StaffModel.fromJson(response?.body).data!.data!);
        staffModel?.data?.currentPage = StaffModel.fromJson(response?.body).data?.currentPage;
        staffModel?.data?.total = StaffModel.fromJson(response?.body).data?.total;
      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }




  bool isLoading = false;
  Future<void> addNewStaff(TeacherBody staffBody) async {
    isLoading = true;
    update();
    Response? response = await staffRepository.addNewStaff(staffBody, Get.find<PickImageController>().thumbnail);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  StaffDetailsModel? staffDetailsModel;
  Future<void> staffDetails(int id) async {
    Response? response = await staffRepository.staffDetails(id);
    if(response?.statusCode == 200){
      staffDetailsModel = StaffDetailsModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

}