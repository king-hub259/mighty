import 'package:mighty_school/helper/price_converter.dart';

class FeesModel {
  bool? status;
  String? message;
  Data? data;


  FeesModel({this.status, this.message, this.data});

  FeesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<FeesItem>? data;
  int? total;

  Data({this.currentPage, this.data,  this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesItem>[];
      json['data'].forEach((v) { data!.add(FeesItem.fromJson(v)); });
    }
    total = json['total'];
  }

}

class FeesItem {
  int? id;
  String? sessionId;
  String? classId;
  String? sectionId;
  String? groupId;
  String? studentCategoryId;
  String? feeHeadId;
  double? feeAmount;
  String? fineAmount;
  String? fundId;
  String? createdAt;
  String? updatedAt;
  Section? section;
  Group? group;
  StudentCategory? studentCategory;
  FeeHead? feeHead;

  FeesItem({this.id, this.sessionId, this.classId, this.sectionId, this.groupId, this.studentCategoryId, this.feeHeadId, this.feeAmount, this.fineAmount, this.fundId, this.createdAt, this.updatedAt, this.section, this.group, this.studentCategory, this.feeHead});

FeesItem.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  sessionId = json['session_id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  groupId = json['group_id'];
  studentCategoryId = json['student_category_id'];
  feeHeadId = json['fee_head_id'].toString();
  feeAmount = PriceConverter.parseAmount(json['fee_amount']);
  fineAmount = json['fine_amount'];
  fundId = json['fund_id'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];

  section = json['section'] != null ? Section.fromJson(json['section']) : null;
  group = json['group'] != null ? Group.fromJson(json['group']) : null;
  studentCategory = json['student_category'] != null ? StudentCategory.fromJson(json['student_category']) : null;
  feeHead = json['fee_head'] != null ? FeeHead.fromJson(json['fee_head']) : null;
  }


}

class Class {
  int? id;
  String? className;

  Class({this.id, this.className});

  Class.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }


}

class Section {
  int? id;
  String? sectionName;

  Section({this.id, this.sectionName});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
  }


}

class Group {
  int? id;
  String? groupName;

  Group({this.id, this.groupName});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
  }


}

class StudentCategory {
  int? id;
  String? name;

  StudentCategory({this.id, this.name});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class FeeHead {
  int? id;
  String? name;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead({this.id, this.name, this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) { feeSubHeads!.add(FeeSubHeads.fromJson(v)); });
    }
  }


}

class FeeSubHeads {
  int? id;
  String? feeHeadId;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;


  FeeSubHeads({this.id, this.feeHeadId, this.name, this.serial, this.createdAt, this.updatedAt});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeHeadId = json['fee_head_id'];
    name = json['name'];
    serial = json['serial'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
