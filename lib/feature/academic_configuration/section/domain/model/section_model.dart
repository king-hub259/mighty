class SectionModel {
  bool? status;
  String? message;
  Data? data;

  SectionModel({this.status, this.message, this.data});

  SectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<SectionItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SectionItem>[];
      json['data'].forEach((v) {
        data!.add(SectionItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class SectionItem {
  int? id;
  String? classId;
  String? studentGroupId;
  String? sectionName;
  String? roomNo;
  String? status;
  String? createdAt;
  String? updatedAt;

  SectionItem(
      {this.id,
        this.classId,
        this.studentGroupId,
        this.sectionName,
        this.roomNo,
        this.status,
        this.createdAt,
        this.updatedAt});

  SectionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    studentGroupId = json['student_group_id'];
    sectionName = json['section_name'];
    roomNo = json['room_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
