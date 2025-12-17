class JournalBody {
  String? sToken;
  String? transactionDate;
  int? fundId;
  int? cashLedgerId;
  String? type;
  String? cashDebit;
  String? cashCredit;
  List<int>? ledgerIds;
  List<String>? debits;
  List<String>? credits;
  String? description;
  String? reference;

  JournalBody(
      {this.sToken,
        this.transactionDate,
        this.fundId,
        this.cashLedgerId,
        this.type,
        this.cashDebit,
        this.cashCredit,
        this.ledgerIds,
        this.debits,
        this.credits,
        this.description,
        this.reference});

  JournalBody.fromJson(Map<String, dynamic> json) {
    sToken = json['_token'];
    transactionDate = json['transaction_date'];
    fundId = json['fund_id'];
    cashLedgerId = json['cash_ledger_id'];
    type = json['type'];
    cashDebit = json['cash_debit'];
    cashCredit = json['cash_credit'];
    ledgerIds = json['ledger_ids'].cast<int>();
    debits = json['debits'].cast<String>();
    credits = json['credits'].cast<String>();
    description = json['description'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_token'] = sToken;
    data['transaction_date'] = transactionDate;
    data['fund_id'] = fundId;
    data['cash_ledger_id'] = cashLedgerId;
    data['type'] = type;
    data['cash_debit'] = cashDebit;
    data['cash_credit'] = cashCredit;
    data['ledger_ids'] = ledgerIds;
    data['debits'] = debits;
    data['credits'] = credits;
    data['description'] = description;
    data['reference'] = reference;
    return data;
  }
}
