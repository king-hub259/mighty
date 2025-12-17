import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';

class ReturnAdvanceRepository {
  final ApiClient apiClient;

  ReturnAdvanceRepository({required this.apiClient});
  
  Future<Response?> getReturnAdvance() async {
    return await apiClient.getData("");
  }

  Future<Response?> createReturnAdvance() async {
    return await apiClient.getData("");
  }

  Future<Response?> editReturnAdvance() async {
    return await apiClient.getData("");
  }

  Future<Response?> deleteReturnAdvance() async {
    return await apiClient.getData("");
  }
}
  