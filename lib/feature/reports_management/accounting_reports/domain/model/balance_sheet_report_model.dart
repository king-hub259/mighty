class BalanceSheetReportModel {
  bool? status;
  String? message;
  List<BalanceSheetItem>? data;

  BalanceSheetReportModel({this.status, this.message, this.data});

  BalanceSheetReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BalanceSheetItem>[];
      json['data'].forEach((v) {
        data!.add(BalanceSheetItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BalanceSheetItem {
  int? ledgerId;
  String? ledgerName;
  String? totalDebit;
  String? totalCredit;

  BalanceSheetItem({this.ledgerId, this.ledgerName, this.totalDebit, this.totalCredit});

  BalanceSheetItem.fromJson(Map<String, dynamic> json) {
    ledgerId = json['ledger_id'];
    ledgerName = json['ledger_name'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ledger_id'] = ledgerId;
    data['ledger_name'] = ledgerName;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    return data;
  }
}
