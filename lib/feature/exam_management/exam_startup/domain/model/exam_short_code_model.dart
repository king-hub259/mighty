class ExamShortCodeModel {
  bool? status;
  String? message;
  Data? data;
  ExamShortCodeModel({this.status, this.message, this.data});
  ExamShortCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<ExamShortCodeItem>? data;
  int? total;
  Data({this.currentPage, this.data, this.total});
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ExamShortCodeItem>[];
      json['data'].forEach((v) {
        data!.add(ExamShortCodeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class ExamShortCodeItem {
  int? id;
  String? shortCodeTitle;
  String? shortCodeNote;
  String? defaultId;
  String? totalMark;
  String? acceptPercent;
  String? passMark;
  String? sessionId;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  ExamShortCodeItem(
      {this.id,
        this.shortCodeTitle,
        this.shortCodeNote,
        this.defaultId,
        this.totalMark,
        this.acceptPercent,
        this.passMark,
        this.sessionId,
        this.createdAt,
        this.updatedAt,
        this.isSelected = false,
      });

  ExamShortCodeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortCodeTitle = json['short_code_title'];
    shortCodeNote = json['short_code_note'];
    defaultId = json['default_id'].toString();
    totalMark = json['total_mark'].toString();
    acceptPercent = json['accept_percent'];
    passMark = json['pass_mark'].toString();
    sessionId = json['session_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = json['is_selected'];
  }

}

