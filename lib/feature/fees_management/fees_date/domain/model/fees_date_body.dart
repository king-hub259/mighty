class FeesDateBody {
  List<String>? feeSubHeadId;
  List<String>? payableDate;
  List<String>? fineActiveDate;

  FeesDateBody({this.feeSubHeadId, this.payableDate, this.fineActiveDate});

  FeesDateBody.fromJson(Map<String, dynamic> json) {
    feeSubHeadId = json['fee_sub_head_id'].cast<String>();
    payableDate = json['payable_date'].cast<String>();
    fineActiveDate = json['fine_active_date'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fee_sub_head_id'] = feeSubHeadId;
    data['payable_date'] = payableDate;
    data['fine_active_date'] = fineActiveDate;
    return data;
  }
}
