class ExamAssignStoreBody {
  String? classId;
  List<String>? examIds;
  String? meritProcessTypeId;

  ExamAssignStoreBody({this.classId, this.examIds, this.meritProcessTypeId});

  ExamAssignStoreBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    examIds = json['exam_ids'].cast<String>();
    meritProcessTypeId = json['merit_process_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['exam_ids'] = examIds;
    data['merit_process_type_id'] = meritProcessTypeId;
    return data;
  }
}
