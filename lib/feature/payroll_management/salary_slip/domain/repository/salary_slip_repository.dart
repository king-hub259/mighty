import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class SalarySlipRepository {
  final ApiClient apiClient;

  SalarySlipRepository({required this.apiClient});
  


  Future<Response?> getSalarySlipByMonth(String month, String year) async {
    return await apiClient.getData("${AppConstants.salarySlip}?month=$month&year=$year");
  }

  Future<Response?> createSalarySlip(SalarySlipBody body) async {
    return await apiClient.postData(AppConstants.salaryCreate, body.toJson());
  }

}
  