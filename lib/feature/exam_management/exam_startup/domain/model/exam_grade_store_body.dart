class ExamGradeStoreBody {
  String? classId;
  List<String>? selectedGrades;

  ExamGradeStoreBody({this.classId, this.selectedGrades});

  ExamGradeStoreBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    selectedGrades = json['selected_grades'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['selected_grades'] = selectedGrades;
    return data;
  }
}
