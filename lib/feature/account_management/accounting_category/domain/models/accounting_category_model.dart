class AccountingCategoryModel {
  bool? status;
  String? message;
  Data? data;


  AccountingCategoryModel({this.status, this.message, this.data});
  AccountingCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<AccountingCategoryItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AccountingCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(AccountingCategoryItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class AccountingCategoryItem {
  int? id;
  String? name;
  String? type;
  String? nature;
  String? createdAt;
  String? updatedAt;

  AccountingCategoryItem(
      {this.id,
        this.name,
        this.type,
        this.nature,
        this.createdAt,
        this.updatedAt});

  AccountingCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    nature = json['nature'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}


