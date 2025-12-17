class StudentSubjectModel {
  bool? status;
  String? message;
  List<SubjectItem>? data;


  StudentSubjectModel({this.status, this.message, this.data});

  StudentSubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubjectItem>[];
      json['data'].forEach((v) {
        data!.add(SubjectItem.fromJson(v));
      });
    }

  }
}

class SubjectItem {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? classId;
  String? groupId;

  SubjectItem(
      {this.id,
        this.subjectName,
        this.subjectCode,
        this.classId,
        this.groupId});

  SubjectItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    classId = json['class_id'].toString();
    groupId = json['group_id'].toString();
  }
}
