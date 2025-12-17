class SubHeadWiseCalculationBody {
  int? studentId;
  int? feeHeadId;
  List<int>? feeSubHeadIds;

  SubHeadWiseCalculationBody(
      {this.studentId, this.feeHeadId, this.feeSubHeadIds});

  SubHeadWiseCalculationBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    feeHeadId = json['fee_head_id'];
    feeSubHeadIds = json['fee_sub_head_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['fee_head_id'] = feeHeadId;
    data['fee_sub_head_ids'] = feeSubHeadIds;
    return data;
  }
}
