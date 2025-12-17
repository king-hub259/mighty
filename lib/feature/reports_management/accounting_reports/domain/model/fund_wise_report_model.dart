class FundWiseReportModel {
  bool? status;
  String? message;
  List<Data>? data;

  FundWiseReportModel({this.status, this.message, this.data});

  FundWiseReportModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? instituteId;
  int? branchId;
  int? voucherId;
  int? categoryId;
  int? fundId;
  int? fundToId;
  int? paymentMethodId;
  int? paymentMethodToId;
  String? transactionDate;
  String? type;
  String? reference;
  String? description;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  int? accountTransactionsId;
  int? ledgerId;
  String? debit;
  String? credit;
  String? fundName;

  Data(
      {this.id,
        this.instituteId,
        this.branchId,
        this.voucherId,
        this.categoryId,
        this.fundId,
        this.fundToId,
        this.paymentMethodId,
        this.paymentMethodToId,
        this.transactionDate,
        this.type,
        this.reference,
        this.description,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.accountTransactionsId,
        this.ledgerId,
        this.debit,
        this.credit,
        this.fundName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    voucherId = json['voucher_id'];
    categoryId = json['category_id'];
    fundId = json['fund_id'];
    fundToId = json['fund_to_id'];
    paymentMethodId = json['payment_method_id'];
    paymentMethodToId = json['payment_method_to_id'];
    transactionDate = json['transaction_date'];
    type = json['type'];
    reference = json['reference'];
    description = json['description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountTransactionsId = json['account_transactions_id'];
    ledgerId = json['ledger_id'];
    debit = json['debit'];
    credit = json['credit'];
    fundName = json['fund_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['voucher_id'] = voucherId;
    data['category_id'] = categoryId;
    data['fund_id'] = fundId;
    data['fund_to_id'] = fundToId;
    data['payment_method_id'] = paymentMethodId;
    data['payment_method_to_id'] = paymentMethodToId;
    data['transaction_date'] = transactionDate;
    data['type'] = type;
    data['reference'] = reference;
    data['description'] = description;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['account_transactions_id'] = accountTransactionsId;
    data['ledger_id'] = ledgerId;
    data['debit'] = debit;
    data['credit'] = credit;
    data['fund_name'] = fundName;
    return data;
  }
}
