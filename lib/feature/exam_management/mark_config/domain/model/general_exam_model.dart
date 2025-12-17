class GeneralExamModel {
  bool? status;
  String? message;
  GeneralExamItem? data;


  GeneralExamModel({this.status, this.message, this.data});

  GeneralExamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GeneralExamItem.fromJson(json['data']) : null;

  }

}

class GeneralExamItem {
  int? classId;
  int? groupId;
  List<Subjects>? subjects;
  List<ClassExams>? classExams;


  GeneralExamItem({this.classId, this.groupId, this.subjects, this.classExams});

  GeneralExamItem.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    groupId = json['groupId'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) { subjects!.add(Subjects.fromJson(v)); });
    }
    if (json['classExams'] != null) {
      classExams = <ClassExams>[];
      json['classExams'].forEach((v) { classExams!.add(ClassExams.fromJson(v)); });
    }

  }

}

class Subjects {
  int? id;
  String? classId;
  String? subjectName;

  Subjects({this.id, this.classId, this.subjectName});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    subjectName = json['subject_name'];
  }

}

class ClassExams {
  int? id;
  String? classId;
  String? examId;
  String? meritProcessTypeId;
  String? createdAt;
  String? updatedAt;
  String? sessionId;
  Exam? exam;
  ClassItem? classItem;
  MeritType? meritType;

  ClassExams({this.id, this.classId, this.examId, this.meritProcessTypeId, this.createdAt, this.updatedAt, this.sessionId, this.exam, this.classItem, this.meritType});

  ClassExams.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  classId = json['class_id'];
  examId = json['exam_id'];
  meritProcessTypeId = json['merit_process_type_id'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  sessionId = json['session_id'];
  exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  classItem = json['class'] != null ? ClassItem.fromJson(json['class']) : null;
  meritType = json['merit_type'] != null ? MeritType.fromJson(json['merit_type']) : null;
  }


}

class Exam {
  int? id;
  String? sessionId;
  String? name;
  String? examCode;

  Exam({this.id, this.sessionId, this.name, this.examCode});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    name = json['name'];
    examCode = json['exam_code'];
  }

}

class ClassItem {
  int? id;
  String? className;

  ClassItem({this.id, this.className});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

}

class MeritType {
  int? id;
  String? type;
  String? serial;

  MeritType({this.id, this.type, this.serial});

  MeritType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    serial = json['serial'];
  }

}
