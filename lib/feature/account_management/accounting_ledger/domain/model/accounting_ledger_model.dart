class AccountingLedgerModel {
  bool? status;
  String? message;
  Data? data;

  AccountingLedgerModel({this.status, this.message, this.data});

  AccountingLedgerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<AccountingLedgerItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AccountingLedgerItem>[];
      json['data'].forEach((v) {
        data!.add(AccountingLedgerItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class AccountingLedgerItem {
  int? id;
  String? ledgerName;
  String? accountingCategoryId;
  String? accountingGroupId;
  String? balance;
  String? type;
  String? createdAt;
  String? updatedAt;

  AccountingLedgerItem(
      {this.id,
        this.ledgerName,
        this.accountingCategoryId,
        this.accountingGroupId,
        this.balance,
        this.type,
        this.createdAt,
        this.updatedAt});

  AccountingLedgerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ledgerName = json['ledger_name'];
    accountingCategoryId = json['accounting_category_id'].toString();
    accountingGroupId = json['accounting_group_id'].toString();
    balance = json['balance'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}


