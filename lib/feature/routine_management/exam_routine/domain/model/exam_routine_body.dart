class ExamRoutineBody {
  String? classId;
  String? groupId;
  String? examId;
  List<SubjectIds>? subjectIds;

  ExamRoutineBody({this.classId, this.groupId, this.examId, this.subjectIds});

  ExamRoutineBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    groupId = json['group_id'];
    examId = json['exam_id'];
    if (json['subject_ids'] != null) {
      subjectIds = <SubjectIds>[];
      json['subject_ids'].forEach((v) {
        subjectIds!.add(SubjectIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['exam_id'] = examId;
    if (subjectIds != null) {
      data['subject_ids'] = subjectIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectIds {
  int? subjectId;
  String? date;
  String? startTime;
  String? endTime;
  String? room;

  SubjectIds(
      {this.subjectId, this.date, this.startTime, this.endTime, this.room});

  SubjectIds.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['room'] = room;
    return data;
  }
}
