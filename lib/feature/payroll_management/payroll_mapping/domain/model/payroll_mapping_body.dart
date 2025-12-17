class PayrollMappingBody {
  int? ledgerId;
  int? fundId;

  PayrollMappingBody({this.ledgerId, this.fundId});

  PayrollMappingBody.fromJson(Map<String, dynamic> json) {
    ledgerId = json['ledger_id'];
    fundId = json['fund_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ledger_id'] = ledgerId;
    data['fund_id'] = fundId;
    return data;
  }
}
