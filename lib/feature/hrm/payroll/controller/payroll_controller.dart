
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_body.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_model.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/repository/payroll_repository.dart';

class PayrollController extends GetxController implements GetxService{
  final PayrollRepository payrollRepository;
  PayrollController({required this.payrollRepository});



  bool isLoading = false;
  PayrollModel? payrollModel;
  Future<void> getPayrollList(int offset) async {
    isLoading = true;
    Response? response = await payrollRepository.getPayrollList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        payrollModel = PayrollModel.fromJson(response?.body);
      }else{
        payrollModel?.data?.data?.addAll(PayrollModel.fromJson(response?.body).data!.data!);
        payrollModel?.data?.currentPage = PayrollModel.fromJson(response?.body).data?.currentPage;
        payrollModel?.data?.total = PayrollModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<String> monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  List<String> yearList = [
     "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030"
  ];
  List<String> paymentMethodList = ["cash", "cheque", "bank_transfer", "mfs"];
  List<String> paymentStatusList = ["pending", "paid", "partial"];
  String? selectedPaymentMethod;
  String? selectedPaymentStatus;
  String? selectedMonth;
  String? selectedYear;
  void setSelectedMonth(String? selectedMonth){
    this.selectedMonth = selectedMonth;
    update();
  }

  void setSelectedPaymentMethod(String method){
    selectedPaymentMethod = method;
    update();
  }

  void setSelectedPaymentStatus(String status){
    selectedPaymentStatus = status;
    update();
  }

  void setSelectedYear(String year){
    selectedYear = year;
    update();
  }

  EmployeeItem? selectedEmployeeItem;
  void setSelectedEmployeeItem(EmployeeItem? employeeItem){
    selectedEmployeeItem = employeeItem;
    update();
  }

  DateTime selectedDate = DateTime.now();
  String formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  Future<void> setSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formatedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      log("message=== $selectedDate");
    }
    update();
  }

  Future<void> createNewPayroll(PayrollBody payrollBody,) async {
    isLoading = true;
    update();
    Response? response = await payrollRepository.createNewPayroll(payrollBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("payroll_added_successfully".tr, isError: false);
      getPayrollList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePayroll(PayrollBody payrollBody, int id) async {
    isLoading = true;
    update();
    Response? response = await payrollRepository.updatePayroll(payrollBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("payroll_updated_successfully".tr, isError: false);
      getPayrollList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePayroll(int id) async {
    isLoading = true;
    Response? response = await payrollRepository.deletePayroll(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("payroll_deleted_successfully".tr, isError: false);
      getPayrollList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
}