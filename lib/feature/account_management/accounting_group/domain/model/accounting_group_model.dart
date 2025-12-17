class AccountingGroupModel {
  bool? status;
  String? message;
  Data? data;

  AccountingGroupModel({this.status, this.message, this.data});

  AccountingGroupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<AccountingGroupItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AccountingGroupItem>[];
      json['data'].forEach((v) {
        data!.add(AccountingGroupItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class AccountingGroupItem {
  int? id;
  String? accountingCategoryId;
  String? name;
  String? createdAt;
  String? updatedAt;

  AccountingGroupItem(
      {this.id,
        this.accountingCategoryId,
        this.name,
        this.createdAt,
        this.updatedAt});

  AccountingGroupItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountingCategoryId = json['accounting_category_id'].toString();
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

