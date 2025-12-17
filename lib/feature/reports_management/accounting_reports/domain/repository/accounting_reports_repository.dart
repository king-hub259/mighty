import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AccountingReportsRepository {
  final ApiClient apiClient;

  AccountingReportsRepository({required this.apiClient});

  // Balance Sheet
  Future<Response?> getBalanceSheet({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "from_date=$startDate&";
    if (endDate != null) query += "to_date=$endDate";
    return await apiClient.getData("${AppConstants.balanceSheet}$query");
  }

  // Trial Balance
  Future<Response?> getTrialBalance({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.trialBalance}$query");
  }

  // Income Statement
  Future<Response?> getIncomeStatement({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.incomeStatement}$query");
  }

  // Cash Flow Statement
  Future<Response?> getCashFlowStatement({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.cashFlowStatement}$query");
  }

  // Cash Flow Details
  Future<Response?> getCashFlowDetails({String? startDate, String? endDate, int? fundId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (fundId != null) query += "fund_id=$fundId&";
    return await apiClient.getData("${AppConstants.cashFlowDetails}$query");
  }

  // Voucher Wise
  Future<Response?> getVoucherWise({String? startDate, String? endDate, String? voucherType}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (voucherType != null) query += "voucher_type=$voucherType&";
    return await apiClient.getData("${AppConstants.voucherWise}$query");
  }

  // Journal Wise
  Future<Response?> getJournalWise({String? startDate, String? endDate, int? journalId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (journalId != null) query += "journal_id=$journalId&";
    return await apiClient.getData("${AppConstants.journalWise}$query");
  }

  // User Wise
  Future<Response?> getUserWise({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.userWise}$query");
  }

  // Ledger Wise
  Future<Response?> getLedgerWise({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.ledgerWise}$query");
  }

  // Fund Wise
  Future<Response?> getFundWise({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.fundWise}$query");
  }

  // Fund Summary
  Future<Response?> getFundSummary({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.fundSummary}$query");
  }

  // Fund Summary Monthly
  Future<Response?> getFundSummaryMonthly({String? year, String? month}) async {
    String query = "?";
    if (year != null) query += "year=$year&";
    if (month != null) query += "month=$month&";
    return await apiClient.getData("${AppConstants.fundSummaryMonthly}$query");
  }
}
  