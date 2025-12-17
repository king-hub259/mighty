class FeesBody {
  String? classId;
  String? groupId;
  String? studentCategoryId;
  String? feeHeadId;
  String? feeAmount;
  String? fineAmount;
  String? fundId;

  FeesBody(
      {this.classId,
        this.groupId,
        this.studentCategoryId,
        this.feeHeadId,
        this.feeAmount,
        this.fineAmount,
        this.fundId});

  FeesBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    groupId = json['group_id'];
    studentCategoryId = json['student_category_id'];
    feeHeadId = json['fee_head_id'];
    feeAmount = json['fee_amount'];
    fineAmount = json['fine_amount'];
    fundId = json['fund_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['student_category_id'] = studentCategoryId;
    data['fee_head_id'] = feeHeadId;
    data['fee_amount'] = feeAmount;
    data['fine_amount'] = fineAmount;
    data['fund_id'] = fundId;
    return data;
  }
}
