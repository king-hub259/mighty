import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/model/salary_payment_info_model.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/repository/salary_repository.dart';

class SalaryController extends GetxController implements GetxService {
  final SalaryRepository salaryRepository;
  SalaryController({required this.salaryRepository});

  SalaryModel? salaryModel;
  EmployeeModel? employeeModel;

  Future<void> getSalaryList(String month, String year) async {
    Response? response = await salaryRepository.getSalaryList(month, year);
    if (response?.statusCode == 200) {
      salaryModel = SalaryModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getEmployeeList() async {
    Response? response = await salaryRepository.getEmployeeList();
    if (response?.statusCode == 200) {
      employeeModel = EmployeeModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> processSalary(String month, String year, List<int> employeeIds) async {
    loading = true;
    update();

    Map<String, dynamic> salaryData = {
      'month': month,
      'year': year,
      'employee_ids': employeeIds,
    };

    Response? response = await salaryRepository.processSalary(salaryData);
    if (response!.statusCode == 200) {
      loading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);

    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  // Form data
  List<String> monthList = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  List<String> yearList = [
    "2020", "2021", "2022", "2023", "2024", "2025", "2026"
  ];

  String? selectedMonth;
  String? selectedYear;
  List<EmployeeItem> selectedEmployees = [];

  void setSelectedMonth(String? month) {
    selectedMonth = month;
    update();
  }

  void setSelectedYear(String? year) {
    selectedYear = year;
    update();
  }

  void toggleEmployeeSelection(EmployeeItem employee) {
    if (selectedEmployees.contains(employee)) {
      selectedEmployees.remove(employee);
    } else {
      selectedEmployees.add(employee);
    }
    update();
  }

  void selectAllEmployees() {
    if (employeeModel?.data?.data != null) {
      selectedEmployees = List.from(employeeModel!.data!.data!);
    }
    update();
  }

  void clearEmployeeSelection() {
    selectedEmployees.clear();
    update();
  }

  void clearForm() {
    selectedMonth = null;
    selectedYear = null;
    selectedEmployees.clear();
    update();
  }

  SalaryPaymentInfoModel? salaryPaymentInfoModel;
  Future<void> getSalaryPaymentInfo() async {
    Response? response = await salaryRepository.getPaymentInfo();
    if (response?.statusCode == 200) {
      salaryPaymentInfoModel = SalaryPaymentInfoModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  