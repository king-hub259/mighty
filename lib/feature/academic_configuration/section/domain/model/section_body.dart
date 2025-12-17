class SectionBody {
  String? sectionName;
  String? classId;
  String? studentGroup;
  String? classTeacher;
  String? method;

  SectionBody(
      {this.sectionName, this.classId, this.studentGroup, this.classTeacher, this.method});

  SectionBody.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
    classId = json['class_id'];
    studentGroup = json['student_group_id'];
    classTeacher = json['class_teacher'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_name'] = sectionName;
    data['class_id'] = classId;
    data['student_group_id'] = studentGroup;
    data['class_teacher'] = classTeacher;
    data['_method'] = method;
    return data;
  }
}
