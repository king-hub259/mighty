import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class PayrollRepository{
  final ApiClient apiClient;
  PayrollRepository({required this.apiClient});


  Future<Response?> getPayrollList(int page) async {
    return await apiClient.getData("${AppConstants.payroll}?page=$page&perPage=10");
  }

  Future<Response?> createNewPayroll(PayrollBody payrollBody) async {
    return await apiClient.postData(AppConstants.payroll, payrollBody.toJson());
  }

  Future<Response?> updatePayroll(PayrollBody payrollBody, int id) async {
    return await apiClient.putData("${AppConstants.payroll}/$id", payrollBody.toJson());
  }
  

  Future<Response?> deletePayroll (int id) async {
    return await apiClient.deleteData("${AppConstants.payroll}/$id");
  }
}