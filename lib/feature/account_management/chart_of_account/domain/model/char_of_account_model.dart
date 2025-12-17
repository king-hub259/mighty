class ChartOfAccountModel {
  bool? status;
  String? message;
  Data? data;


  ChartOfAccountModel({this.status, this.message, this.data,});

  ChartOfAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }


}

class Data {
  int? currentPage;
  List<ChartOfAccountItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ChartOfAccountItem>[];
      json['data'].forEach((v) {
        data!.add(ChartOfAccountItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class ChartOfAccountItem {
  int? id;
  String? name;
  String? nature;
  String? type;
  List<AccountingGroups>? accountingGroups;

  ChartOfAccountItem({this.id, this.name, this.nature, this.type, this.accountingGroups});

  ChartOfAccountItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nature = json['nature'];
    type = json['type'];
    if (json['accounting_groups'] != null) {
      accountingGroups = <AccountingGroups>[];
      json['accounting_groups'].forEach((v) {
        accountingGroups!.add(AccountingGroups.fromJson(v));
      });
    }
  }

}

class AccountingGroups {
  int? id;
  String? accountingCategoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<AccountingLedgers>? accountingLedgers;

  AccountingGroups(
      {this.id,
        this.accountingCategoryId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.accountingLedgers});

  AccountingGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountingCategoryId = json['accounting_category_id'].toString();
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['accounting_ledgers'] != null) {
      accountingLedgers = <AccountingLedgers>[];
      json['accounting_ledgers'].forEach((v) {
        accountingLedgers!.add(AccountingLedgers.fromJson(v));
      });
    }
  }

}

class AccountingLedgers {
  int? id;
  String? ledgerName;
  String? accountingCategoryId;
  String? accountingGroupId;
  String? balance;
  String? type;
  String? createdAt;
  String? updatedAt;

  AccountingLedgers(
      {this.id,
        this.ledgerName,
        this.accountingCategoryId,
        this.accountingGroupId,
        this.balance,
        this.type,
        this.createdAt,
        this.updatedAt});

  AccountingLedgers.fromJson(Map<String, dynamic> json) {
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

