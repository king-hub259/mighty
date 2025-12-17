import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/model/hostel_bill_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelBillRepository {
  final ApiClient apiClient;

  HostelBillRepository({required this.apiClient});

  Future<Response?> getHostelBillsList(int page) async {
    return await apiClient.getData("${AppConstants.hostelBills}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelBill(HostelBillBody billBody) async {
    return await apiClient.postData(AppConstants.hostelBills, billBody.toJson());
  }

  Future<Response?> updateHostelBill(int id, HostelBillBody billBody) async {
    return await apiClient.putData("${AppConstants.hostelBills}/$id", billBody.toJson());
  }

  Future<Response?> deleteHostelBill(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelBills}/$id");
  }

  Future<Response?> getHostelBillDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelBills}/$id");
  }
}
  