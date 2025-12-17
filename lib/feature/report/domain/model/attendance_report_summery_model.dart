import 'package:mighty_school/helper/price_converter.dart';

class AttendanceSummeryModel {
  bool? status;
  String? message;
  List<AttendanceSummeryItem>? data;


  AttendanceSummeryModel({this.status, this.message, this.data});

  AttendanceSummeryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AttendanceSummeryItem>[];
      json['data'].forEach((v) {
        data!.add(AttendanceSummeryItem.fromJson(v));
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

class AttendanceSummeryItem {
  String? date;
  double? present;
  double? presentPercentage;
  double? absent;
  double? absentPercentage;

  AttendanceSummeryItem(
      {this.date,
        this.present,
        this.presentPercentage,
        this.absent,
        this.absentPercentage});

  AttendanceSummeryItem.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    present = PriceConverter.parseAmount(json['present']);
    presentPercentage = PriceConverter.parseAmount(json['present_percentage']);
    absent = PriceConverter.parseAmount(json['absent']);
    absentPercentage = PriceConverter.parseAmount(json['absent_percentage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['present'] = present;
    data['present_percentage'] = presentPercentage;
    data['absent'] = absent;
    data['absent_percentage'] = absentPercentage;
    return data;
  }
}
