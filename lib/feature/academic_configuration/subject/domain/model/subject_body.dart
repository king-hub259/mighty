class SubjectBody {
  int? classId;
  int? groupId;
  String? subjectName;
  String? subjectCode;
  String? subjectShortForm;
  String? subjectType;
  String? subjectTypeForm;
  String? serialNo;

  SubjectBody(
      {this.classId,
        this.groupId,
        this.subjectName,
        this.subjectCode,
        this.subjectShortForm,
        this.subjectType,
        this.subjectTypeForm,
        this.serialNo,
      });

  SubjectBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    groupId = json['group_id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectShortForm = json['subject_short_form'];
    subjectType = json['subject_type'];
    subjectTypeForm = json['subject_type_form'];
    serialNo = json['sl_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['subject_short_form'] = subjectShortForm;
    data['subject_type'] = subjectType;
    data['subject_type_form'] = subjectTypeForm;
    data['sl_no'] = serialNo;
    return data;
  }
}
