import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:mighty_school/util/app_constants.dart';

class AdvanceRepository {
  final ApiClient apiClient;

  AdvanceRepository({required this.apiClient});

  Future<Response?> getAdvanceSalaryList(int page) async {
    return await apiClient.getData("${AppConstants.advanceSalaryPayment}?page=$page&perPage=10");
  }

  Future<Response?> createAdvanceSalary(AdvanceSalaryBody advanceSalaryBody) async {
    return await apiClient.postData(AppConstants.advanceSalaryPayment, advanceSalaryBody.toJson());
  }

  Future<Response?> updateAdvanceSalary(AdvanceSalaryBody advanceSalaryBody, int id) async {
    return await apiClient.putData("${AppConstants.advanceSalaryPayment}/$id", advanceSalaryBody.toJson());
  }

  Future<Response?> deleteAdvanceSalary(int id) async {
    return await apiClient.deleteData("${AppConstants.advanceSalaryPayment}/$id");
  }

  Future<Response?> getEmployeeList() async {
    return await apiClient.getData(AppConstants.employee);
  }
}
  