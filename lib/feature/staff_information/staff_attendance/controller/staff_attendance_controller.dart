
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/domain/models/user_model.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/domain/repository/staff_attendance_repository.dart';

class StaffAttendanceController extends GetxController implements GetxService{
  final StaffAttendanceRepository staffAttendanceRepository;
  StaffAttendanceController({required this.staffAttendanceRepository});




  bool isLoading = false;
  UserModel? userModel;
  Future<void> getStaffListForAttendance(String type) async {
    Response? response = await staffAttendanceRepository.getStaffListForAttendance(type);
    if (response?.statusCode == 200) {
      userModel = UserModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> createStaffAttendance(String type) async {
    Response? response = await staffAttendanceRepository.getStaffListForAttendance(type);
    if (response?.statusCode == 200) {
      userModel = UserModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  List<String> staffTypes = ["Student" , "Teacher" , "Staff", "Admin", "Parent"];
  String? selectedStaffType;
  void setSelectedStaffType(String type){
    selectedStaffType = type;
    update();
  }



  List<String> presentTypeList = ["present", "absent", "late"];
  int selectedPresentTypeIndex = -1;

  void setPresentType(int index, int employeeIndex){
    selectedPresentTypeIndex = index;
    userModel?.data?[employeeIndex].presentType = presentTypeList[index];
    update();
  }

  void setClockInTime(String time, int index){
    userModel?.data?[index].checkIn = time;
    update();
  }

  void setClockOutTime(String time, int index){
    userModel?.data?[index].checkOut = time;
    update();
  }


  String timeOfDayTo24Hour(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0'); // Ensures 2-digit hours
    final minutes = timeOfDay.minute.toString().padLeft(2, '0'); // Ensures 2-digit minutes
    return '$hours:$minutes';
  }


  TimeOfDay selectedTime = const TimeOfDay(hour: 09, minute: 00);
  TimeOfDay selectedCheckoutTime = const TimeOfDay(hour: 05, minute: 00);
  Future<void> pickTime(int index,{bool checkOut = false}) async {
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
        userModel?.data?[index].checkOut = timeOfDayTo24Hour(selectedCheckoutTime);
      }else{
        selectedTime = time;
        userModel?.data?[index].checkIn = timeOfDayTo24Hour(selectedTime);
      }

    }
    update();

  }




  //
  // int allPresent = -1;
  // void setAllPresent(int present){
  //   allPresent = present;
  //   if(present == 0){
  //     for(var present in studentForAttendanceModel!.data!){
  //       present.isPresent = true;
  //     }
  //   }else{
  //     for(var present in studentForAttendanceModel!.data!){
  //       present.isPresent = false;
  //     }
  //   }
  //   update();
  // }
  //
  // Future<void> updateAttendanceStatus(int index, bool status) async {
  //   studentForAttendanceModel?.data?[index].isPresent = status;
  //   update();
  // }
  //
  //
  //
  //
  // Future<void> createStudentNewAttendance(AttendanceBody attendanceBody) async {
  //   isLoading = true;
  //   update();
  //   Response? response = await studentAttendanceRepository.createNewStudentAttendance(attendanceBody);
  //   if(response!.statusCode == 200){
  //     isLoading = false;
  //     Get.back();
  //     showCustomSnackBar("attendance_created_successfully".tr, isError: false);
  //
  //
  //   }else{
  //     ApiChecker.checkApi(response);
  //   }
  //   isLoading = false;
  //   update();
  //
  // }
  //
  // Future<void> updateAttendance(AttendanceBody attendanceBody, int id) async {
  //   isLoading = true;
  //   update();
  //   Response? response = await studentAttendanceRepository.updateAttendance(attendanceBody, id);
  //   if(response!.statusCode == 200){
  //     isLoading = false;
  //     Get.back();
  //     showCustomSnackBar("attendance_updated_successfully".tr, isError: false);
  //   }else{
  //     ApiChecker.checkApi(response);
  //   }
  //   isLoading = false;
  //   update();
  //
  // }
  //
  // TimeOfDay selectedTime = TimeOfDay.now();
  // TimeOfDay selectedCheckoutTime = TimeOfDay.now();
  // Future<void> pickTime({bool checkOut = false}) async {
  //   final TimeOfDay? time = await showTimePicker(
  //     context: Get.context!,
  //     initialTime: selectedTime,
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
  //     },
  //   );
  //   if (time != null && time != selectedTime ) {
  //     if(checkOut){
  //       selectedCheckoutTime = time;
  //     }else{
  //       selectedTime = time;
  //     }
  //
  //   }
  //   update();
  //
  // }
  //
  //
  // Future<void> deleteAttendance(int id) async {
  //   isLoading = true;
  //   Response? response = await studentAttendanceRepository.deleteAttendance(id);
  //   if (response?.statusCode == 200) {
  //     showCustomSnackBar("category_deleted_successfully".tr, isError: false);
  //     isLoading = false;
  //   }else{
  //     isLoading = false;
  //     ApiChecker.checkApi(response!);
  //   }
  //   update();
  // }
  
}