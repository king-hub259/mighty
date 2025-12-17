import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/department/domain/models/department_model.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_body.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/repository/employee_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class EmployeeController extends GetxController implements GetxService{
  final EmployeeRepository employeeRepository;
  EmployeeController({required this.employeeRepository});



  bool isLoading = false;
  EmployeeModel? employeeModel;
  Future<void> getEmployeeList(int offset) async {
    isLoading = true;
    Response? response = await employeeRepository.getEmployeeList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        employeeModel = EmployeeModel.fromJson(response?.body);
      }else{
        employeeModel?.data?.data?.addAll(EmployeeModel.fromJson(response?.body).data!.data!);
        employeeModel?.data?.currentPage = EmployeeModel.fromJson(response?.body).data?.currentPage;
        employeeModel?.data?.total = EmployeeModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<String> presentTypeList = ["present", "absent", "late"];
  int selectedPresentTypeIndex = -1;

  void setPresentType(int index, int employeeIndex){
    selectedPresentTypeIndex = index;
    employeeModel?.data?.data?[employeeIndex].presentType = presentTypeList[index];
    update();
  }

  void setClockInTime(String time, int index){
    employeeModel?.data?.data?[index].checkIn = time;
    update();
  }

  void setClockOutTime(String time, int index){
    employeeModel?.data?.data?[index].checkOut = time;
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
        employeeModel?.data?.data?[index].checkOut = timeOfDayTo24Hour(selectedCheckoutTime);
      }else{
        selectedTime = time;
        employeeModel?.data?.data?[index].checkIn = timeOfDayTo24Hour(selectedTime);
      }

    }
    update();

  }





  List<String> roleList = ["employee", "manager"];
  String? selectedRole;
  void setSelectedRole(String role) {
    selectedRole = role;
    update();
  }

  List<String> userType = ["staff", "teacher "];
  String? selectedUserType;
  void setSelectedUserType(String type) {
    selectedUserType = type;
    update();
  }


  DepartmentItem? selectedDepartment;
  void setSelectedDepartment(DepartmentItem departmentItem) {
    selectedDepartment = departmentItem;
    update();
  }

  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    log("Here is image size ==> $imageSizeIs");
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }


  Future<void> createNewEmployee(EmployeeBody employeeBody,) async {
    isLoading = true;
    update();
    Response? response = await employeeRepository.createNewEmployee(employeeBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("employee_added_successfully".tr, isError: false);
      getEmployeeList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateEmployee(EmployeeBody employeeBody, int id) async {
    isLoading = true;
    update();
    Response? response = await employeeRepository.updateEmployee(employeeBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("employee_updated_successfully".tr, isError: false);
      getEmployeeList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteEmployee(int id) async {
    isLoading = true;
    Response? response = await employeeRepository.deleteEmployee(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("employee_deleted_successfully".tr, isError: false);
      getEmployeeList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
}