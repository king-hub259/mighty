import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';
import 'package:mighty_school/util/app_constants.dart';

class PayrollStartUpRepository {
  final ApiClient apiClient;

  PayrollStartUpRepository({required this.apiClient});

  Future<Response?> getSalaryHeadList(int page) async {
    return await apiClient.getData("${AppConstants.salaryHead}?page=$page&per_page=10");
  }

  Future<Response?> createSalaryHead(SalaryHeadBody salaryHeadBody) async {
    return await apiClient.postData(AppConstants.salaryHead, salaryHeadBody.toJson());
  }

  Future<Response?> updateSalaryHead(SalaryHeadBody salaryHeadBody, int id) async {
    return await apiClient.putData("${AppConstants.salaryHead}/$id", salaryHeadBody.toJson());
  }

  Future<Response?> deleteSalaryHead(int id) async {
    return await apiClient.deleteData("${AppConstants.salaryHead}/$id");
  }

  Future<Response?> getSalaryHeadDetails(int id) async {
    return await apiClient.getData("${AppConstants.salaryHead}/$id");
  }
}
  