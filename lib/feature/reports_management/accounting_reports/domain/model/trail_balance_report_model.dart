class TrailBalanceReportModel {
  bool? status;
  String? message;
  List<Data>? data;

  TrailBalanceReportModel({this.status, this.message, this.data});

  TrailBalanceReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? ledgerId;
  String? ledgerName;
  String? totalDebit;
  String? totalCredit;

  Data({this.ledgerId, this.ledgerName, this.totalDebit, this.totalCredit});

  Data.fromJson(Map<String, dynamic> json) {
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
