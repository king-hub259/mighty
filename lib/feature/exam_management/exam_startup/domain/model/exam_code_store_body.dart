class ExamCodeStoreBody {
  int? classId;
  List<int>? selectedCodes;

  ExamCodeStoreBody({this.classId, this.selectedCodes});

  ExamCodeStoreBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    selectedCodes = json['selected_codes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['selected_codes'] = selectedCodes;
    return data;
  }
}
