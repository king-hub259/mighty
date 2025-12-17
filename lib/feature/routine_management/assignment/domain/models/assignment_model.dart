class AssignmentModel {
  bool? status;
  String? message;
  Data? data;


  AssignmentModel({this.status, this.message, this.data});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<AssignmentItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AssignmentItem>[];
      json['data'].forEach((v) {
        data!.add(AssignmentItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class AssignmentItem {
  int? id;
  String? sessionId;
  String? title;
  String? description;
  String? deadline;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? file;
  String? file2;
  String? file3;
  String? file4;
  String? createdAt;
  String? updatedAt;
  String? className;
  String? status;
  String? studentGroupId;
  String? sectionName;
  String? roomNo;
  String? subjectName;
  String? subjectCode;
  String? subjectType;
  String? slNo;
  String? objective;
  String? written;
  String? practical;
  String? fullMark;
  String? passMark;

  AssignmentItem(
      {this.id,
        this.sessionId,
        this.title,
        this.description,
        this.deadline,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.file,
        this.file2,
        this.file3,
        this.file4,
        this.createdAt,
        this.updatedAt,
        this.className,
        this.status,
        this.studentGroupId,
        this.sectionName,
        this.roomNo,
        this.subjectName,
        this.subjectCode,
        this.subjectType,
        this.slNo,
        this.objective,
        this.written,
        this.practical,
        this.fullMark,
        this.passMark
      });

  AssignmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'].toString();
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    classId = json['class_id'].toString();
    sectionId = json['section_id'].toString();
    subjectId = json['subject_id'].toString();
    file = json['file'];
    file2 = json['file_2'];
    file3 = json['file_3'];
    file4 = json['file_4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class_name'];
    status = json['status'].toString();
    studentGroupId = json['student_group_id'].toString();
    sectionName = json['section_name'];
    roomNo = json['room_no'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectType = json['subject_type'];
    slNo = json['sl_no'].toString();
    objective = json['objective'].toString();
    written = json['written'].toString();
    practical = json['practical'].toString();
    fullMark = json['full_mark'].toString();
    passMark = json['pass_mark'].toString();
  }
}


