

import 'package:mighty_school/helper/price_converter.dart';

class ParentPaidReportModel {
  bool? status;
  String? message;
  Data? data;

  ParentPaidReportModel({this.status, this.message, this.data});

  ParentPaidReportModel.fromJson(Map<String, dynamic> json) {
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
  Student? student;
  double? totalPaidAmount;
  List<CollectionHistory>? collectionHistory;

  Data({this.student, this.totalPaidAmount, this.collectionHistory});

  Data.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    totalPaidAmount = PriceConverter.parseAmount( json['total_paid_amount']);
    if (json['collection_history'] != null) {
      collectionHistory = <CollectionHistory>[];
      json['collection_history'].forEach((v) {
        collectionHistory!.add(CollectionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['total_paid_amount'] = totalPaidAmount;
    if (collectionHistory != null) {
      data['collection_history'] =
          collectionHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  String? name;
  String? roll;
  int? classId;
  int? sectionId;

  Student({this.name, this.roll, this.classId, this.sectionId});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roll = json['roll'];
    classId = json['class_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['roll'] = roll;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    return data;
  }
}

class CollectionHistory {
  String? invoiceId;
  String? invoiceDate;
  String? feeHeadName;
  String? paidAmount;
  String? waiver;
  String? fineAmount;
  String? previousDuePaid;

  CollectionHistory(
      {this.invoiceId,
        this.invoiceDate,
        this.feeHeadName,
        this.paidAmount,
        this.waiver,
        this.fineAmount,
        this.previousDuePaid});

  CollectionHistory.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    feeHeadName = json['fee_head_name'];
    paidAmount = json['paid_amount'];
    waiver = json['waiver'];
    fineAmount = json['fine_amount'];
    previousDuePaid = json['previous_due_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['invoice_date'] = invoiceDate;
    data['fee_head_name'] = feeHeadName;
    data['paid_amount'] = paidAmount;
    data['waiver'] = waiver;
    data['fine_amount'] = fineAmount;
    data['previous_due_paid'] = previousDuePaid;
    return data;
  }
}
