import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/repository/advance_repository.dart';

class AdvanceController extends GetxController implements GetxService {
  final AdvanceRepository advanceRepository;
  AdvanceController({required this.advanceRepository});

  AdvanceSalaryModel? advanceSalaryModel;
  EmployeeModel? employeeModel;

  Future<void> getAdvanceSalaryList(int page) async {
    Response? response = await advanceRepository.getAdvanceSalaryList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        advanceSalaryModel = AdvanceSalaryModel.fromJson(response?.body);
      } else {
        advanceSalaryModel?.data?.data?.addAll(AdvanceSalaryModel.fromJson(response?.body).data!.data!);
        advanceSalaryModel?.data?.currentPage = AdvanceSalaryModel.fromJson(response?.body).data?.currentPage;
        advanceSalaryModel?.data?.total = AdvanceSalaryModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getEmployeeList() async {
    Response? response = await advanceRepository.getEmployeeList();
    if (response?.statusCode == 200) {
      employeeModel = EmployeeModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> createAdvanceSalary(AdvanceSalaryBody advanceSalaryBody) async {
    loading = true;
    update();
    Response? response = await advanceRepository.createAdvanceSalary(advanceSalaryBody);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> editAdvanceSalary(AdvanceSalaryBody advanceSalaryBody, int id) async {
    loading = true;
    update();
    Response? response = await advanceRepository.updateAdvanceSalary(advanceSalaryBody, id);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deleteAdvanceSalary(int id) async {
    Response? response = await advanceRepository.deleteAdvanceSalary(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Form controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  List<String> statusList = ["pending", "approved", "rejected"];
  String? selectedStatus;
  EmployeeItem? selectedEmployee;
  DateTime selectedDate = DateTime.now();
  String formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    update();
  }

  void setSelectedEmployee(EmployeeItem? employee) {
    selectedEmployee = employee;
    update();
  }

  Future<void> setSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formatedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
    }
    update();
  }

  void clearForm() {
    amountController.clear();
    reasonController.clear();
    notesController.clear();
    selectedStatus = null;
    selectedEmployee = null;
    selectedDate = DateTime.now();
    formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
    update();
  }

  void fillForm(AdvanceSalaryItem advanceSalaryItem) {
    amountController.text = advanceSalaryItem.amount?.toString() ?? '';
    reasonController.text = advanceSalaryItem.reason ?? '';
    notesController.text = advanceSalaryItem.notes ?? '';
    selectedStatus = advanceSalaryItem.status;
    // Note: You'll need to find the employee from the list
    update();
  }
}
  