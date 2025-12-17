class ParentExamModel {
  bool? status;
  String? message;
  List<ParentExamItem>? data;

  ParentExamModel({this.status, this.message, this.data});

  ParentExamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ParentExamItem>[];
      json['data'].forEach((v) {
        data!.add(ParentExamItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParentExamItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? classId;
  int? examId;
  int? meritProcessTypeId;
  Exam? exam;
  MeritType? meritType;

  ParentExamItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.classId,
        this.examId,
        this.meritProcessTypeId,
        this.exam,
        this.meritType});

  ParentExamItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    classId = json['class_id'];
    examId = json['exam_id'];
    meritProcessTypeId = json['merit_process_type_id'];
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
    meritType = json['merit_type'] != null
        ? MeritType.fromJson(json['merit_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['class_id'] = classId;
    data['exam_id'] = examId;
    data['merit_process_type_id'] = meritProcessTypeId;
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    if (meritType != null) {
      data['merit_type'] = meritType!.toJson();
    }
    return data;
  }
}

class Exam {
  int? id;
  int? sessionId;
  String? name;
  String? examCode;

  Exam({this.id, this.sessionId, this.name, this.examCode});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    name = json['name'];
    examCode = json['exam_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session_id'] = sessionId;
    data['name'] = name;
    data['exam_code'] = examCode;
    return data;
  }
}

class MeritType {
  int? id;
  String? type;
  int? serial;

  MeritType({this.id, this.type, this.serial});

  MeritType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['serial'] = serial;
    return data;
  }
}
