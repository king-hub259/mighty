class PaymentBody {
  String? type;
  String? transactionDate;
  int? paymentMethodId;
  List<int>? ledgerIds;
  List<String>? amounts;
  int? fundId;
  String? reference;
  String? description;

  PaymentBody(
      {this.type,
        this.transactionDate,
        this.paymentMethodId,
        this.ledgerIds,
        this.amounts,
        this.fundId,
        this.reference,
        this.description});

  PaymentBody.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    transactionDate = json['transaction_date'];
    paymentMethodId = json['payment_method_id'];
    ledgerIds = json['ledger_ids'].cast<int>();
    amounts = json['amounts'].cast<int>();
    fundId = json['fund_id'];
    reference = json['reference'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['transaction_date'] = transactionDate;
    data['payment_method_id'] = paymentMethodId;
    data['ledger_ids'] = ledgerIds;
    data['amounts'] = amounts;
    data['fund_id'] = fundId;
    data['reference'] = reference;
    data['description'] = description;
    return data;
  }
}
