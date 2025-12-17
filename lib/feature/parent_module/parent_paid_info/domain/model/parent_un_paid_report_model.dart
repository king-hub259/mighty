

import 'package:mighty_school/helper/price_converter.dart';

class ParentUnPaidReportModel {
  bool? status;
  String? message;
  Data? data;

  ParentUnPaidReportModel({this.status, this.message, this.data});

  ParentUnPaidReportModel.fromJson(Map<String, dynamic> json) {
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
  StudentData? studentData;

  Data({this.studentData});

  Data.fromJson(Map<String, dynamic> json) {
    studentData = json['student_data'] != null
        ? StudentData.fromJson(json['student_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentData != null) {
      data['student_data'] = studentData!.toJson();
    }
    return data;
  }
}

class StudentData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? roll;
  String? className;
  String? sectionName;
  String? groupName;
  int? studentCategoryId;
  List<ParentFeeHeads>? feeHeads;
  double? totalDueAmount;

  StudentData(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.roll,
        this.className,
        this.sectionName,
        this.groupName,
        this.studentCategoryId,
        this.feeHeads,
        this.totalDueAmount});

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    groupName = json['group_name'];
    studentCategoryId = json['student_category_id'];
    if (json['fee_heads'] != null) {
      feeHeads = <ParentFeeHeads>[];
      json['fee_heads'].forEach((v) {
        feeHeads!.add(ParentFeeHeads.fromJson(v));
      });
    }
    totalDueAmount = PriceConverter.parseAmount(json['total_due_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['roll'] = roll;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['group_name'] = groupName;
    data['student_category_id'] = studentCategoryId;
    if (feeHeads != null) {
      data['fee_heads'] = feeHeads!.map((v) => v.toJson()).toList();
    }
    data['total_due_amount'] = totalDueAmount;
    return data;
  }
}

class ParentFeeHeads {
  int? feeHeadId;
  String? feeHeadName;
  List<ParentSubHeads>? subHeads;

  ParentFeeHeads({this.feeHeadId, this.feeHeadName, this.subHeads});

  ParentFeeHeads.fromJson(Map<String, dynamic> json) {
    feeHeadId = json['fee_head_id'];
    feeHeadName = json['fee_head_name'];
    if (json['sub_heads'] != null) {
      subHeads = <ParentSubHeads>[];
      json['sub_heads'].forEach((v) {
        subHeads!.add(ParentSubHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fee_head_id'] = feeHeadId;
    data['fee_head_name'] = feeHeadName;
    if (subHeads != null) {
      data['sub_heads'] = subHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParentSubHeads {
  int? subHeadId;
  String? subHeadName;
  double? feeAndFinePayable;

  ParentSubHeads({this.subHeadId, this.subHeadName, this.feeAndFinePayable});

  ParentSubHeads.fromJson(Map<String, dynamic> json) {
    subHeadId = json['sub_head_id'];
    subHeadName = json['sub_head_name'];
    feeAndFinePayable = PriceConverter.parseAmount(json['fee_and_fine_payable']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_head_id'] = subHeadId;
    data['sub_head_name'] = subHeadName;
    data['fee_and_fine_payable'] = feeAndFinePayable;
    return data;
  }
}
