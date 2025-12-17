import 'package:mighty_school/helper/price_converter.dart';

class AttendanceFineModel {
  bool? status;
  String? message;
  Data? data;

  AttendanceFineModel({this.status, this.message, this.data});

  AttendanceFineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? studentName;
  String? roll;
  String? sectionName;
  String? attendanceFine;
  double? totalFineAmount;
  List<Months>? months;

  Data(
      {this.studentName,
        this.roll,
        this.sectionName,
        this.attendanceFine,
        this.totalFineAmount,
        this.months});

  Data.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    roll = json['roll'];
    sectionName = json['section_name'];
    attendanceFine = json['attendance_fine'];
    totalFineAmount = PriceConverter.parseAmount(json['total_fine_amount']);
    if (json['months'] != null) {
      months = <Months>[];
      json['months'].forEach((v) {
        months!.add(Months.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    data['roll'] = roll;
    data['section_name'] = sectionName;
    data['attendance_fine'] = attendanceFine;
    data['total_fine_amount'] = totalFineAmount;
    if (months != null) {
      data['months'] = months!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Months {
  int? month;
  String? monthName;
  int? absentCount;
  String? fineAmount;

  Months({this.month, this.monthName, this.absentCount, this.fineAmount});

  Months.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    monthName = json['month_name'];
    absentCount = json['absent_count'];
    fineAmount = json['fine_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['month_name'] = monthName;
    data['absent_count'] = absentCount;
    data['fine_amount'] = fineAmount;
    return data;
  }
}
