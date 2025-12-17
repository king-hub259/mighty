class ContraBody {
  String? transactionDate;
  String? type;
  int? paymentMethodId;
  int? paymentMethodToId;
  int? amount;
  String? reference;
  String? description;

  ContraBody(
      {this.transactionDate,
        this.type,
        this.paymentMethodId,
        this.paymentMethodToId,
        this.amount,
        this.reference,
        this.description});

  ContraBody.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    type = json['type'];
    paymentMethodId = json['payment_method_id'];
    paymentMethodToId = json['payment_method_to_id'];
    amount = json['amount'];
    reference = json['reference'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_date'] = transactionDate;
    data['type'] = type;
    data['payment_method_id'] = paymentMethodId;
    data['payment_method_to_id'] = paymentMethodToId;
    data['amount'] = amount;
    data['reference'] = reference;
    data['description'] = description;
    return data;
  }
}
