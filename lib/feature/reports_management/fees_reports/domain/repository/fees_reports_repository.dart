import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesReportsRepository {
  final ApiClient apiClient;

  FeesReportsRepository({required this.apiClient});

  Future<Response?> getMonthlyReport({String? year, String? month}) async {
    String query = "?";
    if (year != null) query += "year=$year&";
    if (month != null) query += "month=$month";
    return await apiClient.getData("${AppConstants.monthlyReport}$query");
  }

  // Payment Fees Info
  Future<Response?> getPaymentFeesInfo({String? startDate, String? endDate, int? classId, int? sectionId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId&";
    return await apiClient.getData("${AppConstants.paymentFeesInfo}$query");
  }

  // Head Wise Payment
  Future<Response?> getHeadWisePayment({String? startDate, String? endDate, int? feeHeadId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (feeHeadId != null) query += "fee_head_id=$feeHeadId&";
    return await apiClient.getData("${AppConstants.headWisePayment}$query");
  }

  // Head Wise Due
  Future<Response?> getHeadWiseDue({String? startDate, String? endDate, int? feeHeadId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (feeHeadId != null) query += "fee_head_id=$feeHeadId&";
    return await apiClient.getData("${AppConstants.headWiseDue}$query");
  }

  // Class Wise Payment Summary
  Future<Response?> getClassWisePaymentSummary({String? startDate, String? endDate, int? classId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (classId != null) query += "class_id=$classId&";
    return await apiClient.getData("${AppConstants.classWisePaymentSummary}$query");
  }

  // Unpaid Info
  Future<Response?> getUnpaidInfo({int? classId, int? sectionId, int? feeHeadId}) async {
    String query = "?";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId&";
    if (feeHeadId != null) query += "fee_head_id=$feeHeadId&";
    return await apiClient.getData("${AppConstants.unpaidInfo}$query");
  }

  // Payment Ratio Info
  Future<Response?> getPaymentRatioInfo({String? startDate, String? endDate}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    return await apiClient.getData("${AppConstants.paymentRatioInfo}$query");
  }

  // Unpaid Summary
  Future<Response?> getUnpaidSummary({int? classId, int? sectionId}) async {
    String query = "?";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId&";
    return await apiClient.getData("${AppConstants.unpaidSummery}$query");
  }

  // Paid Invoice
  Future<Response?> getPaidInvoice({String? startDate, String? endDate, int? studentId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (studentId != null) query += "student_id=$studentId&";
    return await apiClient.getData("${AppConstants.paidInvoice}$query");
  }
}
  