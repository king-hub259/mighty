class BehaviorModel {
  bool? status;
  String? message;
  Data? data;

  BehaviorModel({this.status, this.message, this.data});

  BehaviorModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<BehaviorItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BehaviorItem>[];
      json['data'].forEach((v) {
        data!.add(BehaviorItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class BehaviorItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? title;
  int? sessionId;
  String? date;
  int? studentId;
  int? classId;
  int? sectionId;
  String? note;
  String? file;

  BehaviorItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.title,
        this.sessionId,
        this.date,
        this.studentId,
        this.classId,
        this.sectionId,
        this.note,
        this.file});

  BehaviorItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    title = json['title'];
    sessionId = json['session_id'];
    date = json['date'];
    studentId = json['student_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    note = json['note'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['title'] = title;
    data['session_id'] = sessionId;
    data['date'] = date;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['note'] = note;
    data['file'] = file;
    return data;
  }
}


