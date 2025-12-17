import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class EmployeeRepository{
  final ApiClient apiClient;
  EmployeeRepository({required this.apiClient});


  Future<Response?> getEmployeeList(int page) async {
    return await apiClient.getData("${AppConstants.employee}?page=$page&per_page=20");
  }

  Future<Response?> createNewEmployee(EmployeeBody employeeBody) async {
    return await apiClient.postData(AppConstants.employee, employeeBody.toJson());
  }

  Future<Response?> updateEmployee(EmployeeBody employeeBody, int id) async {

    return await apiClient.putData("${AppConstants.employee}/$id", employeeBody.toJson());
  }
  

  Future<Response?> deleteEmployee (int id) async {
    return await apiClient.deleteData("${AppConstants.employee}/$id");
  }
}