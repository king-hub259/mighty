import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/report/domain/model/chart_data.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/domain/domain/saas_admin_dashboard_report_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/domain/repository/saas_admin_dashboard_repository.dart';

class SaasAdminDashboardController extends GetxController implements GetxService {
  final SaasAdminDashboardRepository saasAdminDashboardRepository;
  SaasAdminDashboardController({required this.saasAdminDashboardRepository});
  bool isLoading = false;
  List<ChartData> collectedData = [];
  SaasAdminDashboardReportModel? saasAdminDashboardReportModel;
  Future<void> getSaasAdminDashboardReport() async {
    Response? response = await saasAdminDashboardRepository.getSaasAdminDashboardReport();
    if (response!.statusCode == 200) {
      saasAdminDashboardReportModel = SaasAdminDashboardReportModel.fromJson(response.body);
      if(saasAdminDashboardReportModel != null && saasAdminDashboardReportModel?.data?.transactions != null && saasAdminDashboardReportModel!.data!.transactions!.isNotEmpty){
        for(var incomeExpense in saasAdminDashboardReportModel!.data!.transactions!){
          collectedData.add(ChartData(incomeExpense.month!, incomeExpense.totalPaid!));
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}