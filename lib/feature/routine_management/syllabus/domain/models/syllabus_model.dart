class SyllabusModel {
  bool? status;
  String? message;
  Data? data;

  SyllabusModel({this.status, this.message, this.data});

  SyllabusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<SyllabusItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SyllabusItem>[];
      json['data'].forEach((v) {
        data!.add(SyllabusItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class SyllabusItem {
  int? id;
  String? sessionId;
  String? title;
  String? description;
  String? classId;
  String? file;
  String? createdAt;
  String? updatedAt;
  String? className;
  String? status;

  SyllabusItem(
      {this.id,
        this.sessionId,
        this.title,
        this.description,
        this.classId,
        this.file,
        this.createdAt,
        this.updatedAt,
        this.className,
        this.status});

  SyllabusItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'].toString();
    title = json['title'];
    description = json['description'];
    classId = json['class_id'].toString();
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class_name'];
    status = json['status'].toString();
  }

}


