class CashFlowStatementReportModel {
  bool? status;
  String? message;
  List<Data>? data;

  CashFlowStatementReportModel({this.status, this.message, this.data});

  CashFlowStatementReportModel.fromJson(Map<String, dynamic> json) {
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
  int? year;
  String? month;
  int? totalDebit;
  int? totalCredit;

  Data({this.year, this.month, this.totalDebit, this.totalCredit});

  Data.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    return data;
  }
}
