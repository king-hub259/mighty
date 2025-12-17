import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class SalaryRepository {
  final ApiClient apiClient;

  SalaryRepository({required this.apiClient});

  Future<Response?> getSalaryList(String month, String year) async {
    return await apiClient.getData("${AppConstants.salaryProcess}?year=$year&month=$month");
  }

  Future<Response?> processSalary(Map<String, dynamic> salaryData) async {
    return await apiClient.postData(AppConstants.salaryCreate, salaryData);
  }

  Future<Response?> getSalaryStatement(String month, String year) async {
    return await apiClient.getData("${AppConstants.salaryStatement}?month=$month&year=$year");
  }

  Future<Response?> getEmployeeList() async {
    return await apiClient.getData(AppConstants.employee);
  }

  Future<Response?> getPaymentInfo() async {
    return await apiClient.getData(AppConstants.paymentInfo);
  }
}
  