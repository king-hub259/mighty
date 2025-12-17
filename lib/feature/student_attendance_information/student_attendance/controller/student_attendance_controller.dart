
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_body.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_for_attendance_model.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/repository/student_attendance_repository.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/student_list_for_attendance.dart';
import 'package:mighty_school/helper/responsive_helper.dart';

class StudentAttendanceController extends GetxController implements GetxService{
  final StudentAttendanceRepository studentAttendanceRepository;
  StudentAttendanceController({required this.studentAttendanceRepository});




  bool isLoading = false;
  StudentForAttendanceModel? studentForAttendanceModel;
  Future<void> getStudentListForAttendance(int classId, int sectionId, int groupId, String date) async {
    isLoading = true;
    update();
    Response? response = await studentAttendanceRepository.getStudentListForAttendance(classId, sectionId, groupId, date);
    if (response?.statusCode == 200) {
      studentForAttendanceModel = StudentForAttendanceModel.fromJson(response?.body);
      isLoading = false;
      if(ResponsiveHelper.isMobile(Get.context!)){
        Get.to(()=> const StudentListForAttendance());
      }

    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  int allPresent = -1;
  void setAllPresent(int present){
    allPresent = present;
    if(present == 0){
      for(var present in studentForAttendanceModel!.data!){
        present.isPresent = true;
      }
    }else{
      for(var present in studentForAttendanceModel!.data!){
        present.isPresent = false;
      }
    }
    update();
  }

  Future<void> updateAttendanceStatus(int index, bool status) async {
    studentForAttendanceModel?.data?[index].isPresent = status;
    update();
  }




  Future<void> createStudentNewAttendance(StudentAttendanceBody attendanceBody) async {
    isLoading = true;
    update();
    Response? response = await studentAttendanceRepository.createNewStudentAttendance(attendanceBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("attendance_created_successfully".tr, isError: false);


    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAttendance(StudentAttendanceBody attendanceBody, int id) async {
    isLoading = true;
    update();
    Response? response = await studentAttendanceRepository.updateAttendance(attendanceBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("attendance_updated_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedCheckoutTime = TimeOfDay.now();
  Future<void> pickTime({bool checkOut = false}) async {
    final TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
      },
    );
    if (time != null && time != selectedTime ) {
      if(checkOut){
        selectedCheckoutTime = time;
      }else{
        selectedTime = time;
      }

    }
    update();

  }


  Future<void> deleteAttendance(int id) async {
    isLoading = true;
    Response? response = await studentAttendanceRepository.deleteAttendance(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("category_deleted_successfully".tr, isError: false);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
}