import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class PaidInfoRepository{
  final ApiClient apiClient;
  PaidInfoRepository({required this.apiClient});

  Future<Response?> getPaidInfo(String from, String to) async {
    return await apiClient.getData("${AppConstants.paidReport}?from_date=$from&to_date=$to");
  }

  Future<Response?> getUnPaidInfo() async {
    return await apiClient.getData("${AppConstants.unPaidReport}?class_id=1&section_id=1",);
  }

}