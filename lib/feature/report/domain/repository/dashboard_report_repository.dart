import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class DashboardReportRepository{
  final ApiClient apiClient;
  DashboardReportRepository({required this.apiClient});


  Future<Response?> getDashboardData() async {
    return await apiClient.getData(AppConstants.dashboardData);
  }

  Future<Response?> getYearlyCashFlowData(String year, String month) async {
    return await apiClient.getData("${AppConstants.yearWiseCashFlow}$year&month=$month");
  }

  Future<Response?> getAttendanceSummeryData(String type) async {
    return await apiClient.getData("${AppConstants.attendanceSummery}?type=$type");
  }
  Future<Response?> getFeesCollectionSummeryData(String year) async {
    return await apiClient.getData("${AppConstants.monthlyFeeCollectionSummery}?year=$year");
  }

}