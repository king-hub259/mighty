class FeesMappingModel {
  bool? status;
  String? message;
  Data? data;


  FeesMappingModel({this.status, this.message, this.data});

  FeesMappingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<FeesMappingItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesMappingItem>[];
      json['data'].forEach((v) {
        data!.add(FeesMappingItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class FeesMappingItem {
  int? id;
  String? feeHeadId;
  String? ledgerId;
  String? type;
  String? createdAt;
  String? updatedAt;
  FeeHead? feeHead;
  FeeLedger? feeLedger;

  FeesMappingItem(
      {this.id,
        this.feeHeadId,
        this.ledgerId,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.feeHead,
        this.feeLedger});

  FeesMappingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeHeadId = json['fee_head_id'].toString();
    ledgerId = json['ledger_id'].toString();
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feeHead = json['fee_head'] != null
        ? FeeHead.fromJson(json['fee_head'])
        : null;
    feeLedger = json['fee_ledger'] != null
        ? FeeLedger.fromJson(json['fee_ledger'])
        : null;
  }

}

class FeeHead {
  int? id;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead(
      {this.id,
        this.name,
        this.serial,
        this.createdAt,
        this.updatedAt,
        this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = json['serial'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
  }

}

class FeeSubHeads {
  int? id;
  String? feeHeadId;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;

  FeeSubHeads(
      {this.id,
        this.feeHeadId,
        this.name,
        this.serial,
        this.createdAt,
        this.updatedAt});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeHeadId = json['fee_head_id'];
    name = json['name'];
    serial = json['serial'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}



class FeeLedger {
  int? id;
  String? ledgerName;
  String? accountingCategoryId;
  String? accountingGroupId;
  String? balance;
  String? type;


  FeeLedger(
      {this.id,
        this.ledgerName,
        this.accountingCategoryId,
        this.accountingGroupId,
        this.balance,
        this.type});

  FeeLedger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ledgerName = json['ledger_name'];
    accountingCategoryId = json['accounting_category_id'].toString();
    accountingGroupId = json['accounting_group_id'].toString();
    balance = json['balance'];
    type = json['type'];
  }

}

