
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_details_model.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_body.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_model.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/repository/teacher_repository.dart';

class TeacherController extends GetxController implements GetxService{
  final TeacherRepository teacherRepository;
  TeacherController({required this.teacherRepository});

  TeacherModel? teacherModel;
  Future<void> getTeacherList(int page) async {
    Response? response = await teacherRepository.getTeacherList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        teacherModel = TeacherModel.fromJson(response?.body);
      }else{
        teacherModel?.data?.data?.addAll(TeacherModel.fromJson(response?.body).data!.data!);
        teacherModel?.data?.currentPage = TeacherModel.fromJson(response?.body).data?.currentPage;
        teacherModel?.data?.total = TeacherModel.fromJson(response?.body).data?.total;
      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  TeacherItem? selectedTeacherItem;
  void selectTeacher(TeacherItem item){
    selectedTeacherItem = item;
    update();
  }


  bool isLoading = false;
  Future<void> addNewTeacher(TeacherBody teacherBody) async {
    isLoading = true;
    update();
    Response? response = await teacherRepository.addNewTeacher(teacherBody, Get.find<PickImageController>().thumbnail);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      getTeacherList(1);
      showCustomSnackBar("added_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> updateTeacher(TeacherBody teacherBody, int id) async {
    isLoading = true;
    update();
    Response? response = await teacherRepository.updateTeacher(teacherBody, Get.find<PickImageController>().thumbnail, id);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      getTeacherList(1);
      showCustomSnackBar("added_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  StudentDetailsModel? studentDetailsModel;
  Future<void> teacherDetails(int id) async {
    Response? response = await teacherRepository.teacherDetails(id);
    if(response?.statusCode == 200){
      studentDetailsModel = StudentDetailsModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> deleteTeacher(int id) async {
    Response? response = await teacherRepository.deleteTeacher(id);
    if(response?.statusCode == 200){
     showCustomSnackBar("deleted_successfully".tr);
     getTeacherList(1);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

}