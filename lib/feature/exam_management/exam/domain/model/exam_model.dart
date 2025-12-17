class ExamModel {
  bool? status;
  String? message;
  Data? data;

  ExamModel({this.status, this.message, this.data});

  ExamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<ExamItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ExamItem>[];
      json['data'].forEach((v) {
        data!.add(ExamItem.fromJson(v));
      });
    }

    total = json['total'];
  }

}

class ExamItem {
  int? id;
  String? sessionId;
  String? name;
  String? examCode;
  String? note;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  ExamItem(
      {this.id,
        this.sessionId,
        this.name,
        this.examCode,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isSelected});

  ExamItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'].toString();
    name = json['name'];
    examCode = json['exam_code'];
    note = json['note'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = false;
  }

}


