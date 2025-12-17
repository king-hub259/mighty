import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/domain/model/payroll_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class PayrollAssignRepository {
  final ApiClient apiClient;

  PayrollAssignRepository({required this.apiClient});
  
  Future<Response?> getPayrollAssign() async {
    return await apiClient.getData(AppConstants.payrollAssign);
  }

  Future<Response?> createPayrollAssign(PayrollAssignBody body) async {
    return await apiClient.postData(AppConstants.payrollAssign, body.toJson());
  }


}
  