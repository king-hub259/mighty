class AssignmentBody {
  String? title;
  String? deadline;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? description;

  AssignmentBody(
      {this.title,
        this.deadline,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.description});

  AssignmentBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    deadline = json['deadline'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    description = json['description'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title??'';
    data['deadline'] = deadline??'';
    data['class_id'] = classId??'';
    data['section_id'] = sectionId??'';
    data['subject_id'] = subjectId??'';
    data['description'] = description??'';
    return data;
  }
}
