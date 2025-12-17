class GeneralExamStoreBody {
  String? classId;
  String? groupId;
  List<String>? selectedSubjects;
  List<ExamCodes>? examCodes;
  List<String>? selectedExams;


  GeneralExamStoreBody(
      {this.classId,
        this.groupId,
        this.selectedSubjects,
        this.examCodes,
        this.selectedExams});

  GeneralExamStoreBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    groupId = json['group_id'];
    selectedSubjects = json['selected_subjects'].cast<String>();
    if (json['exam_codes'] != null) {
      examCodes = <ExamCodes>[];
      json['exam_codes'].forEach((v) {
        examCodes!.add(ExamCodes.fromJson(v));
      });
    }
    selectedExams = json['selected_exams'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['selected_subjects'] = selectedSubjects;
    if (examCodes != null) {
      data['exam_codes'] = examCodes!.map((v) => v.toJson()).toList();
    }
    data['selected_exams'] = selectedExams;
    return data;
  }
}

class ExamCodes {
  String? title;
  String? totalMarks;
  String? passMark;
  String? acceptance;

  ExamCodes({this.title, this.totalMarks, this.passMark, this.acceptance});

  ExamCodes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    totalMarks = json['total_marks'];
    passMark = json['pass_mark'];
    acceptance = json['acceptance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['total_marks'] = totalMarks;
    data['pass_mark'] = passMark;
    data['acceptance'] = acceptance;
    return data;
  }
}
