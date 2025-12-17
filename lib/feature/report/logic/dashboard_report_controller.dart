
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/home/domain/model/yearly_cash_flow_data_model.dart';
import 'package:mighty_school/feature/report/domain/model/attendance_report_summery_model.dart';
import 'package:mighty_school/feature/report/domain/model/chart_data.dart';
import 'package:mighty_school/feature/report/domain/model/dashboard_report_model.dart';
import 'package:mighty_school/feature/report/domain/model/fees_collection_summery_model.dart';
import 'package:mighty_school/feature/report/domain/repository/dashboard_report_repository.dart';

class DashboardReportController extends GetxController implements GetxService{
  final DashboardReportRepository dashboardReportRepository;
  DashboardReportController({required this.dashboardReportRepository});


  DashboardReportModel? dashboardReportModel;
  Future<void> getDashboardData() async {
    Response? response = await dashboardReportRepository.getDashboardData();
    if (response?.statusCode == 200) {
      dashboardReportModel = DashboardReportModel.fromJson(response?.body);
    }else{
      // ApiChecker.checkApi(response!);
    }
    update();
  }

  List<ChartData> incomeData = [];
  List<ChartData> expenseData = [];
  YearlyCashFlowDataModel? yearlyCashFlowDataModel;
  Future<void> getYearlyCashFlowData(String year, String month) async {
    Response? response = await dashboardReportRepository.getYearlyCashFlowData(year, month);
    if (response?.statusCode == 200) {
     yearlyCashFlowDataModel = YearlyCashFlowDataModel.fromJson(response?.body);
     if(yearlyCashFlowDataModel != null && yearlyCashFlowDataModel!.data!= null && yearlyCashFlowDataModel!.data!.isNotEmpty){
       for(var incomeExpense in yearlyCashFlowDataModel!.data!){
         incomeData.add(ChartData(incomeExpense.month!, incomeExpense.totalCredit!));
         expenseData.add(ChartData(incomeExpense.month!, incomeExpense.totalDebit!));
       }
     }
    }else{
      // ApiChecker.checkApi(response!);
    }
    update();
  }


  List<ChartData> presentData = [];
  List<ChartData> absentData = [];
  AttendanceSummeryModel? attendanceSummeryModel;
  Future<void> getAttendanceSummaryData(String type) async {
    Response? response = await dashboardReportRepository.getAttendanceSummeryData(type);
    if (response?.statusCode == 200) {
      attendanceSummeryModel = AttendanceSummeryModel.fromJson(response?.body);

      if(attendanceSummeryModel != null && attendanceSummeryModel!.data!= null && attendanceSummeryModel!.data!.isNotEmpty){
        for(var incomeExpense in attendanceSummeryModel!.data!){
          presentData.add(ChartData(incomeExpense.date!, incomeExpense.present!));
          absentData.add(ChartData(incomeExpense.date!, incomeExpense.absent!));
        }

      }
    }else{
      // ApiChecker.checkApi(response!);
    }
    update();
  }

  List<ChartData> collectedData = [];
  List<ChartData> outstandingData = [];
  FeesCollectionSummeryModel? feesCollectionSummeryModel;
  Future<void> getFeesCollectionData(String year) async {
    Response? response = await dashboardReportRepository.getFeesCollectionSummeryData(year);
    if (response?.statusCode == 200) {
      feesCollectionSummeryModel = FeesCollectionSummeryModel.fromJson(response?.body);
      if(feesCollectionSummeryModel != null && feesCollectionSummeryModel!.data!= null && feesCollectionSummeryModel!.data!.isNotEmpty){
        for(var incomeExpense in feesCollectionSummeryModel!.data!){
          collectedData.add(ChartData(incomeExpense.month!, incomeExpense.collected!));
          outstandingData.add(ChartData(incomeExpense.month!, incomeExpense.outstanding!));
        }

      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<String> attendanceTypeList = ["weekly", "half_month", "monthly"];
  String selectedAttendanceType = "weekly";
  void setSelectedAttendanceType(String type) {
    selectedAttendanceType = type;
    getAttendanceSummaryData(selectedAttendanceType);
    update();
  }

}