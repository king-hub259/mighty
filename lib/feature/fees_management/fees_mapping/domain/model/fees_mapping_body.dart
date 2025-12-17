class FeesMappingBody {
  String? feeHeadId;
  List<int>? feeSubHeadIds;
  String? ledgerId;
  List<int>? fundIds;
  String? type;

  FeesMappingBody(
      {this.feeHeadId,
        this.feeSubHeadIds,
        this.ledgerId,
        this.fundIds,
        this.type});

  FeesMappingBody.fromJson(Map<String, dynamic> json) {
    feeHeadId = json['fee_head_id'];
    feeSubHeadIds = json['fee_sub_head_ids'].cast<int>();
    ledgerId = json['ledger_id'];
    fundIds = json['fund_ids'].cast<int>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fee_head_id'] = feeHeadId;
    data['fee_sub_head_ids'] = feeSubHeadIds;
    data['ledger_id'] = ledgerId;
    data['fund_ids'] = fundIds;
    data['type'] = type;
    return data;
  }
}
