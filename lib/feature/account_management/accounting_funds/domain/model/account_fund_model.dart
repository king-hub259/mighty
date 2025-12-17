class AccountingFundModel {
  bool? status;
  String? message;
  Data? data;


  AccountingFundModel({this.status, this.message, this.data});

  AccountingFundModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<AccountingFundItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AccountingFundItem>[];
      json['data'].forEach((v) {
        data!.add(AccountingFundItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class AccountingFundItem {
  int? id;
  String? name;
  String? cashIn;
  String? cashOut;
  String? balance;
  String? createdAt;
  String? updatedAt;

  AccountingFundItem(
      {this.id,
        this.name,
        this.cashIn,
        this.cashOut,
        this.balance,
        this.createdAt,
        this.updatedAt});

  AccountingFundItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cashIn = json['cash_in'];
    cashOut = json['cash_out'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

