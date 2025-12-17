import 'package:mighty_school/helper/price_converter.dart';

class FeesMonthlyReportModel {
  bool? status;
  String? message;
  List<MonthlyReportItem>? data;

  FeesMonthlyReportModel({this.status, this.message, this.data});

  FeesMonthlyReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MonthlyReportItem>[];
      json['data'].forEach((v) {
        data!.add(MonthlyReportItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthlyReportItem {
  int? studentId;
  String? roll;
  String? firstName;
  String? invoiceId;
  String? invoiceDate;
  String? details;
  double? totalAmount;

  MonthlyReportItem(
      {this.studentId,
        this.roll,
        this.firstName,
        this.invoiceId,
        this.invoiceDate,
        this.details,
        this.totalAmount});

  MonthlyReportItem.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    roll = json['roll'];
    firstName = json['first_name'];
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    details = json['details'];
    totalAmount = PriceConverter.parseAmount(json['total_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['roll'] = roll;
    data['first_name'] = firstName;
    data['invoice_id'] = invoiceId;
    data['invoice_date'] = invoiceDate;
    data['details'] = details;
    data['total_amount'] = totalAmount;
    return data;
  }
}
