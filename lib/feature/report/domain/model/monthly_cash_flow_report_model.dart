class CahFlowSummeryModel {
  bool? status;
  String? message;
  List<CashFlowItem>? data;


  CahFlowSummeryModel({this.status, this.message, this.data});

  CahFlowSummeryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CashFlowItem>[];
      json['data'].forEach((v) {
        data!.add(CashFlowItem.fromJson(v));
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

class CashFlowItem {
  String? date;
  int? totalDebit;
  int? totalCredit;

  CashFlowItem({this.date, this.totalDebit, this.totalCredit});

  CashFlowItem.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    return data;
  }
}
