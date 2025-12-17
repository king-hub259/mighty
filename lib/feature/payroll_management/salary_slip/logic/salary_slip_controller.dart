
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_body.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_model.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/repository/salary_slip_repository.dart';

class SalarySlipController extends GetxController implements GetxService {
  final SalarySlipRepository salarySlipRepository;
  SalarySlipController({required this.salarySlipRepository});

  SalarySlipModel? salarySlipModel;
  bool isLoading = false;


  Future<void> getSalarySlipByMonth(String month, String year) async {
    isLoading = true;
    update();
      Response? response = await salarySlipRepository.getSalarySlipByMonth(month, year);
      if (response?.statusCode == 200 && response?.body != null) {
        salarySlipModel = SalarySlipModel.fromJson(response!.body);
      } else {
        ApiChecker.checkApi(response!);
      }
    isLoading = false;
    update();
  }


  bool allSelected = false;
  void toggleAllSelection() {
    allSelected = !allSelected;
    if (salarySlipModel?.data?.salarySlips != null) {
      for (var slip in salarySlipModel!.data!.salarySlips!) {
        slip.isSelected = allSelected;
      }
    }
    update();
  }

  toggleSelection(int index) {
    if (salarySlipModel?.data?.salarySlips != null && index < salarySlipModel!.data!.salarySlips!.length) {
      salarySlipModel!.data!.salarySlips![index].isSelected = !salarySlipModel!.data!.salarySlips![index].isSelected;
      allSelected = salarySlipModel!.data!.salarySlips!.every((slip) => slip.isSelected);
      update();
    }
  }




  Future<void> createSalarySlip(SalarySlipBody body) async {
    isLoading = true;
    update();

    Response? response = await salarySlipRepository.createSalarySlip(body);
    if (response?.statusCode == 200) {
      showCustomSnackBar("created_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }

    isLoading = false;
    update();
  }



  List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

  // year 2020 to 2030
  List<String> years = List.generate(11, (index) => (2020 + index).toString());
  String? selectedMonth;
  String? selectedMonthValue;
  String? selectedYear;
  void setSelectedMonth(String? month) {
    selectedMonth = month;
    selectedMonthValue = (months.indexOf(month!) + 1).toString().padLeft(2, '0');
    update();
  }
  void setSelectedYear(String? year) {
    selectedYear = year;
    update();
  }




}
  