class ParentExamResultModel {
  bool? status;
  String? message;
  Data? data;

  ParentExamResultModel({this.status, this.message, this.data});

  ParentExamResultModel.fromJson(Map<String, dynamic> json) {
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
  Student? student;
  Exam? exam;
  List<Subjects>? subjects;
  int? positionInClass;
  String? teacherRemarks;
  String? issueDate;

  Data(
      {this.student,
        this.exam,
        this.subjects,
        this.positionInClass,
        this.teacherRemarks,
        this.issueDate});

  Data.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    positionInClass = json['position_in_class'];
    teacherRemarks = json['teacher_remarks'];
    issueDate = json['issue_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    data['position_in_class'] = positionInClass;
    data['teacher_remarks'] = teacherRemarks;
    data['issue_date'] = issueDate;
    return data;
  }
}

class Student {
  String? id;
  String? name;
  String? section;
  String? roll;

  Student({this.id, this.name, this.section, this.roll});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    section = json['section'];
    roll = json['roll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['section'] = section;
    data['roll'] = roll;
    return data;
  }
}

class Exam {
  String? name;
  int? year;
  int? totalMarks;
  int? obtainedMarks;
  int? percentage;
  String? grade;
  int? gradePoint;
  String? result;

  Exam(
      {this.name,
        this.year,
        this.totalMarks,
        this.obtainedMarks,
        this.percentage,
        this.grade,
        this.gradePoint,
        this.result});

  Exam.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    year = json['year'];
    totalMarks = json['total_marks'];
    obtainedMarks = json['obtained_marks'];
    percentage = json['percentage'];
    grade = json['grade'];
    gradePoint = json['grade_point'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['year'] = year;
    data['total_marks'] = totalMarks;
    data['obtained_marks'] = obtainedMarks;
    data['percentage'] = percentage;
    data['grade'] = grade;
    data['grade_point'] = gradePoint;
    data['result'] = result;
    return data;
  }
}

class Subjects {
  String? name;
  int? fullMarks;
  int? marksObtained;
  String? grade;
  String? remarks;

  Subjects(
      {this.name,
        this.fullMarks,
        this.marksObtained,
        this.grade,
        this.remarks});

  Subjects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fullMarks = json['full_marks'];
    marksObtained = json['marks_obtained'];
    grade = json['grade'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['full_marks'] = fullMarks;
    data['marks_obtained'] = marksObtained;
    data['grade'] = grade;
    data['remarks'] = remarks;
    return data;
  }
}
