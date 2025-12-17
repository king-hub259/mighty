import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/repository/payroll_start_up_repository.dart';

class PayrollStartUpController extends GetxController implements GetxService {
  final PayrollStartUpRepository payrollStartUpRepository;
  PayrollStartUpController({required this.payrollStartUpRepository});

  SalaryHeadModel? salaryHeadModel;

  Future<void> getSalaryHeadList(int page) async {
    Response? response = await payrollStartUpRepository.getSalaryHeadList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        salaryHeadModel = SalaryHeadModel.fromJson(response?.body);
      } else {
        salaryHeadModel?.data?.data?.addAll(SalaryHeadModel.fromJson(response?.body).data!.data!);
        salaryHeadModel?.data?.currentPage = SalaryHeadModel.fromJson(response?.body).data?.currentPage;
        salaryHeadModel?.data?.total = SalaryHeadModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  String? selectedHeadType;
  List<String> headTypes = ["Addition", "Deduction"];
  void setSelectedHeadType(String? type) {
    selectedHeadType = type;
    update();
  }

  bool loading = false;
  Future<void> createSalaryHead(SalaryHeadBody salaryHeadBody) async {
    loading = true;
    update();
    Response? response = await payrollStartUpRepository.createSalaryHead(salaryHeadBody);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSalaryHeadList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> editSalaryHead(SalaryHeadBody salaryHeadBody, int id) async {
    loading = true;
    update();
    Response? response = await payrollStartUpRepository.updateSalaryHead(salaryHeadBody, id);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSalaryHeadList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deleteSalaryHead(int id) async {
    Response? response = await payrollStartUpRepository.deleteSalaryHead(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSalaryHeadList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Form controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> salaryHeadTypes = ["earning", "deduction"];
  List<String> statusList = ["active", "inactive"];
  String? selectedType;
  String? selectedStatus;

  void setSelectedType(String? type) {
    selectedType = type;
    update();
  }

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    update();
  }

  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    selectedType = null;
    selectedStatus = null;
    update();
  }

  void fillForm(SalaryHeadItem salaryHeadItem) {
    nameController.text = salaryHeadItem.name ?? '';
    descriptionController.text = salaryHeadItem.description ?? '';
    selectedType = salaryHeadItem.type;
    selectedStatus = salaryHeadItem.status;
    update();
  }
}
  