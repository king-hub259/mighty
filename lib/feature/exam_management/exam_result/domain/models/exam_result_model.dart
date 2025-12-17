class ExamResultModel {
  bool? status;
  String? message;
  Data? data;
  ExamResultModel({this.status, this.message, this.data});
  ExamResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<ResultItem>? data;
  int? total;

  Data({this.currentPage, this.data,  this.total});
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ResultItem>[];
      json['data'].forEach((v) { data!.add(ResultItem.fromJson(v)); });
    }
    total = json['total'];
  }

}

class ResultItem {
  int? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? groupId;
  String? subjectId;
  String? examId;
  String? mark1;
  String? mark2;
  String? mark3;
  String? mark4;
  String? mark5;
  String? mark6;
  String? totalMarks;
  String? gradePoint;
  String? grade;
  String? createdAt;
  String? updatedAt;
  Student? student;
  ClassInfo? classInfo;
  Group? group;
  Subject? subject;
  Exam? exam;

  ResultItem({this.id, this.sessionId, this.studentId, this.classId, this.groupId, this.subjectId, this.examId, this.mark1, this.mark2, this.mark3, this.mark4, this.mark5, this.mark6, this.totalMarks, this.gradePoint, this.grade, this.createdAt, this.updatedAt, this.student, this.classInfo, this.group, this.subject, this.exam});

  ResultItem.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  sessionId = json['session_id'];
  studentId = json['student_id'];
  classId = json['class_id'];
  groupId = json['group_id'];
  subjectId = json['subject_id'];
  examId = json['exam_id'];
  mark1 = json['mark1'];
  mark2 = json['mark2'];
  mark3 = json['mark3'];
  mark4 = json['mark4'];
  mark5 = json['mark5'];
  mark6 = json['mark6'];
  totalMarks = json['total_marks'];
  gradePoint = json['grade_point'];
  grade = json['grade'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  student = json['student'] != null ? Student.fromJson(json['student']) : null;
  classInfo = json['class'] != null ? ClassInfo.fromJson(json['class']) : null;
  group = json['group'] != null ? Group.fromJson(json['group']) : null;
  subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }


}

class Student {
  int? id;
  String? group;
  String? firstName;
  String? lastName;
  StudentSession? studentSession;

  Student({this.id, this.group, this.firstName, this.lastName, this.studentSession});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    studentSession = json['student_session'] != null ? StudentSession.fromJson(json['student_session']) : null;
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group'] = group;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (studentSession != null) {
      data['student_session'] = studentSession!.toJson();
    }
    return data;
  }


}

class StudentSession {
  int? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? sectionId;
  String? roll;
  String? createdAt;
  String? updatedAt;



  StudentSession({this.id, this.sessionId, this.studentId, this.classId, this.sectionId, this.roll, this.createdAt, this.updatedAt});

  StudentSession.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  sessionId = json['session_id'];
  studentId = json['student_id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  roll = json['roll'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session_id'] = sessionId;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['roll'] = roll;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }


}

class ClassInfo {
  int? id;
  String? className;
  String? status;
  String? createdAt;
  String? updatedAt;

  ClassInfo({this.id, this.className, this.status, this.createdAt, this.updatedAt});

  ClassInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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

class Subject {
  int? id;
  String? subjectName;

  Subject({this.id, this.subjectName});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
  }

}

class Exam {
  int? id;
  String? name;

  Exam({this.id,  this.name});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}


