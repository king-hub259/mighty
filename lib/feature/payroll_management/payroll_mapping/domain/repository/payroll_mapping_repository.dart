import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/model/payroll_mapping_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class PayrollMappingRepository {
  final ApiClient apiClient;

  PayrollMappingRepository({required this.apiClient});

  Future<Response?> getPayrollMappingList(int page) async {
    return await apiClient.getData("${AppConstants.payrollMapping}?page=$page&perPage=10");
  }

  Future<Response?> createPayrollMapping(PayrollMappingBody payrollMappingBody) async {
    return await apiClient.postData(AppConstants.payrollMapping, payrollMappingBody.toJson());
  }

  Future<Response?> updatePayrollMapping(PayrollMappingBody payrollMappingBody, int id) async {
    return await apiClient.putData("${AppConstants.payrollMapping}/$id", payrollMappingBody.toJson());
  }

  Future<Response?> deletePayrollMapping(int id) async {
    return await apiClient.deleteData("${AppConstants.payrollMapping}/$id");
  }

  Future<Response?> getEmployeeList() async {
    return await apiClient.getData(AppConstants.employee);
  }

  Future<Response?> getSalaryHeadList() async {
    return await apiClient.getData(AppConstants.salaryHead);
  }
}
  