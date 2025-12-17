class IncomeStatementReportModel {
  bool? status;
  String? message;
  Data? data;

  IncomeStatementReportModel({this.status, this.message, this.data});

  IncomeStatementReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Ledgers>? ledgers;
  List<Ledgers>? income;
  List<Ledgers>? expense;

  Data({this.ledgers, this.income, this.expense});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ledgers'] != null) {
      ledgers = <Ledgers>[];
      json['ledgers'].forEach((v) {
        ledgers!.add(Ledgers.fromJson(v));
      });
    }
    if (json['income'] != null) {
      income = <Ledgers>[];
      json['income'].forEach((v) {
        income!.add(Ledgers.fromJson(v));
      });
    }
    if (json['expense'] != null) {
      expense = <Ledgers>[];
      json['expense'].forEach((v) {
        expense!.add(Ledgers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ledgers != null) {
      data['ledgers'] = ledgers!.map((v) => v.toJson()).toList();
    }
    if (income != null) {
      data['income'] = income!.map((v) => v.toJson()).toList();
    }
    if (expense != null) {
      data['expense'] = expense!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ledgers {
  int? ledgerId;
  int? accountTransactionsId;
  String? ledgerName;
  String? totalDebit;
  String? totalCredit;

  Ledgers(
      {this.ledgerId,
        this.accountTransactionsId,
        this.ledgerName,
        this.totalDebit,
        this.totalCredit});

  Ledgers.fromJson(Map<String, dynamic> json) {
    ledgerId = json['ledger_id'];
    accountTransactionsId = json['account_transactions_id'];
    ledgerName = json['ledger_name'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ledger_id'] = ledgerId;
    data['account_transactions_id'] = accountTransactionsId;
    data['ledger_name'] = ledgerName;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    return data;
  }
}
