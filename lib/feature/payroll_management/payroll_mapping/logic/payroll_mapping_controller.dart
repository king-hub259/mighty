import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/model/payroll_mapping_body.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/repository/payroll_mapping_repository.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';

class PayrollMappingController extends GetxController implements GetxService {
  final PayrollMappingRepository payrollMappingRepository;
  PayrollMappingController({required this.payrollMappingRepository});

  PayrollMappingModel? payrollMappingModel;
  EmployeeModel? employeeModel;
  SalaryHeadModel? salaryHeadModel;
  

  Future<void> getPayrollMappingList(int page) async {
    Response? response = await payrollMappingRepository.getPayrollMappingList(page);
    if (response?.statusCode == 200) {
      payrollMappingModel = PayrollMappingModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getEmployeeList() async {
    Response? response = await payrollMappingRepository.getEmployeeList();
    if (response?.statusCode == 200) {
      employeeModel = EmployeeModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getSalaryHeadList() async {
    Response? response = await payrollMappingRepository.getSalaryHeadList();
    if (response?.statusCode == 200) {
      salaryHeadModel = SalaryHeadModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> createPayrollMapping(PayrollMappingBody payrollMappingBody) async {
    loading = true;
    update();
    Response? response = await payrollMappingRepository.createPayrollMapping(payrollMappingBody);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPayrollMappingList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> editPayrollMapping(PayrollMappingBody payrollMappingBody, int id) async {
    loading = true;
    update();
    Response? response = await payrollMappingRepository.updatePayrollMapping(payrollMappingBody, id);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPayrollMappingList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deletePayrollMapping(int id) async {
    Response? response = await payrollMappingRepository.deletePayrollMapping(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPayrollMappingList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Form controllers
  TextEditingController amountController = TextEditingController();

  List<String> mappingTypes = ["fixed", "percentage"];
  List<String> statusList = ["active", "inactive"];
  String? selectedType;
  String? selectedStatus;
  EmployeeItem? selectedEmployee;
  SalaryHeadItem? selectedSalaryHead;

  void setSelectedType(String? type) {
    selectedType = type;
    update();
  }

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    update();
  }

  void setSelectedEmployee(EmployeeItem? employee) {
    selectedEmployee = employee;
    update();
  }

  void setSelectedSalaryHead(SalaryHeadItem? salaryHead) {
    selectedSalaryHead = salaryHead;
    update();
  }

  void clearForm() {
    amountController.clear();
    selectedType = null;
    selectedStatus = null;
    selectedEmployee = null;
    selectedSalaryHead = null;
    update();
  }

  void fillForm(PayrollMappingItem payrollMappingItem) {

    update();
  }
}




  