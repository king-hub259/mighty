import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_model.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_request_body.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/repository/leave_request_repository.dart';
import 'package:mighty_school/feature/hrm/leave_type/domain/models/leave_type_model.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class LeaveRequestController extends GetxController implements GetxService{
  final LeaveRequestRepository leaveRequestRepository;
  LeaveRequestController({required this.leaveRequestRepository});



  bool isLoading = false;
  LeaveModel? leaveModel;
  Future<void> getLeaveRequestList(int offset) async {
    isLoading = true;
    Response? response = await leaveRequestRepository.getLeaveRequestList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        leaveModel = LeaveModel.fromJson(response?.body);
      }else{
        leaveModel?.data?.data?.addAll(LeaveModel.fromJson(response?.body).data!.data!);
        leaveModel?.data?.currentPage = LeaveModel.fromJson(response?.body).data?.currentPage;
        leaveModel?.data?.total = LeaveModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
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

  EmployeeItem? selectEmployeeItem;
  void selectEmployee(EmployeeItem employeeItem) {
    selectEmployeeItem = employeeItem;
    update();
  }
  LeaveTypeItem? selectLeaveTypeItem;
  void setSelectLeaveType(LeaveTypeItem leaveTypeItem) {
    selectLeaveTypeItem = leaveTypeItem;
    update();
  }


  DateTime selectedDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime selectedToDate = DateTime.now();
  String formatedFromDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  String formatedToDate = "${DateTime.now().subtract(const Duration(days: 30)).year.toString()}-${DateTime.now().subtract(const Duration(days: 30)).month.toString().padLeft(2,'0')}-${DateTime.now().subtract(const Duration(days: 30)).day.toString().padLeft(2,'0')}";
  Future<void> setSelectDate(BuildContext context, {bool fromDate = false}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {

      if(fromDate){
        selectedDate = picked;
        formatedFromDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      }else{
        selectedToDate = picked;
        formatedToDate = "${selectedToDate.year.toString()}-${selectedToDate.month.toString().padLeft(2,'0')}-${selectedToDate.day.toString().padLeft(2,'0')}";
      }

      log("message=== $selectedDate");
    }
    update();
  }

  Future<void> createNewLeaveRequest(LeaveRequestBody leaveRequestBody) async {
    isLoading = true;
    update();
    Response? response = await leaveRequestRepository.createNewLeaveRequest(leaveRequestBody, thumbnail );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("leave_request_added_successfully".tr, isError: false);
      getLeaveRequestList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateLeaveRequest(LeaveRequestBody leaveRequestBody, int id) async {
    isLoading = true;
    update();
    Response? response = await leaveRequestRepository.updateLeaveRequest(leaveRequestBody, thumbnail, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("leave_request_updated_successfully".tr, isError: false);
      getLeaveRequestList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteLeaveRequest(int id) async {
    isLoading = true;
    Response? response = await leaveRequestRepository.deleteLeaveRequest(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("leave_request_deleted_successfully".tr, isError: false);
      getLeaveRequestList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
}