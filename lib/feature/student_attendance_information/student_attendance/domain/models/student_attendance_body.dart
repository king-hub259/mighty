class StudentAttendanceBody {
  List<int>? studentIds;
  List<int>? attendance;
  int? classId;
  int? sectionId;
  int? periodId;
  int? subjectId;
  String? date;
  int? smsStatus;

  StudentAttendanceBody(
      {this.studentIds,
        this.attendance,
        this.classId,
        this.sectionId,
        this.periodId,
        this.subjectId,
        this.date,
        this.smsStatus});

  StudentAttendanceBody.fromJson(Map<String, dynamic> json) {
    studentIds = json['student_ids'].cast<int>();
    attendance = json['attendance'].cast<int>();
    classId = json['class_id'];
    sectionId = json['section_id'];
    periodId = json['period_id'];
    subjectId = json['subject_id'];
    date = json['date'];
    smsStatus = json['sms_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_ids'] = studentIds;
    data['attendance'] = attendance;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['period_id'] = periodId;
    data['subject_id'] = subjectId;
    data['date'] = date;
    data['sms_status'] = smsStatus;
    return data;
  }
}
