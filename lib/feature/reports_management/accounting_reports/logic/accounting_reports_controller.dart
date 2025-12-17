import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/balance_sheet_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/cash_flow_statemrnt_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/fund_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/income_statement_reports_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/ledger_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/trail_balance_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/user_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/voucher_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/repository/accounting_reports_repository.dart';

class AccountingReportsController extends GetxController implements GetxService {
  final AccountingReportsRepository accountingReportsRepository;
  AccountingReportsController({required this.accountingReportsRepository});

  bool isLoading = false;


  String? startDate = Get.find<DatePickerController>().formatedDate;
  String? endDate = Get.find<DatePickerController>().formatedEndDate;


  // Balance Sheet
  BalanceSheetReportModel? balanceSheetModel;
  Future<void> getBalanceSheet() async {
    Response? response = await accountingReportsRepository.getBalanceSheet(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      balanceSheetModel = BalanceSheetReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }




  // Trial Balance
  TrailBalanceReportModel? trialBalanceModel;
  Future<void> getTrialBalance() async {
    Response? response = await accountingReportsRepository.getTrialBalance(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      trialBalanceModel = TrailBalanceReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Income Statement
  IncomeStatementReportModel? incomeStatementModel;
  Future<void> getIncomeStatement() async {
    Response? response = await accountingReportsRepository.getIncomeStatement(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      incomeStatementModel = IncomeStatementReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Cash Flow Statement
  CashFlowStatementReportModel? cashFlowStatementModel;
  Future<void> getCashFlowStatement() async {
    Response? response = await accountingReportsRepository.getCashFlowStatement(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      cashFlowStatementModel = CashFlowStatementReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // // Cash Flow Details
  // Future<void> getCashFlowDetails({int? fundId}) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await accountingReportsRepository.getCashFlowDetails(startDate: startDate, endDate: endDate, fundId: fundId);
  //   if (response?.statusCode == 200) {
  //     cashFlowDetailsModel = BaseAccountingReportModel.fromJson(response?.body);
  //   } else {
  //     ApiChecker.checkApi(response!);
  //   }
  //
  //   _isLoading = false;
  //   update();
  // }

  // Voucher Wise
  VoucherReportModel? voucherWiseModel;
  Future<void> getVoucherWise({String? voucherType}) async {
    Response? response = await accountingReportsRepository.getVoucherWise(startDate: startDate, endDate: endDate, voucherType: voucherType);
    if (response?.statusCode == 200) {
      voucherWiseModel = VoucherReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Journal Wise

  Future<void> getJournalWise() async {
    Response? response = await accountingReportsRepository.getJournalWise(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      //journalWiseModel = BaseAccountingReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // User Wise
  UserWiseReportModel? userWiseModel;
  Future<void> getUserWise() async {
    Response? response = await accountingReportsRepository.getUserWise(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      userWiseModel = UserWiseReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Ledger Wise
  LedgerWiseReportModel? ledgerWiseModel;
  Future<void> getLedgerWise() async {
    Response? response = await accountingReportsRepository.getLedgerWise(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      ledgerWiseModel = LedgerWiseReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Fund Wise
  FundWiseReportModel? fundWiseModel;
  Future<void> getFundWise({String? startDate, String? endDate, int? fundId}) async {
    Response? response = await accountingReportsRepository.getFundWise(startDate: startDate, endDate: endDate);
    if (response?.statusCode == 200) {
      fundWiseModel = FundWiseReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }




  // Clear all data
  void clearAllData() {
    balanceSheetModel = null;
    trialBalanceModel = null;
    incomeStatementModel = null;
    cashFlowStatementModel = null;
    voucherWiseModel = null;
    userWiseModel = null;
    ledgerWiseModel = null;
    fundWiseModel = null;
    update();
  }
}
  