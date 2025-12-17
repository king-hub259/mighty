class ExamRoutineModel {
  bool? status;
  String? message;
  List<ExamRoutineItem>? data;


  ExamRoutineModel({this.status, this.message, this.data});

  ExamRoutineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ExamRoutineItem>[];
      json['data'].forEach((v) {
        data!.add(ExamRoutineItem.fromJson(v));
      });
    }

  }

}

class ExamRoutineItem {
  String? subjectName;
  String? subjectCode;
  String? subjectType;
  String? classId;
  String? groupId;
  String? id;
  String? examId;
  String? subjectId;
  String? date;
  String? startTime;
  String? endTime;
  String? room;
  String? sessionId;
  String? createdAt;
  String? updatedAt;
  String? schedulesId;
  String? exam;

  ExamRoutineItem(
      {this.subjectName,
        this.subjectCode,
        this.subjectType,
        this.classId,
        this.groupId,
        this.id,
        this.examId,
        this.subjectId,
        this.date,
        this.startTime,
        this.endTime,
        this.room,
        this.sessionId,
        this.createdAt,
        this.updatedAt,
        this.schedulesId,
        this.exam});

  ExamRoutineItem.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectType = json['subject_type'];
    classId = json['class_id'];
    groupId = json['group_id'].toString();
    id = json['id'];
    examId = json['exam_id'];
    subjectId = json['subject_id'].toString();
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    room = json['room'];
    sessionId = json['session_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    schedulesId = json['schedules_id'];
    exam = json['exam'];
  }

}
