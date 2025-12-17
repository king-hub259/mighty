class PayrollMappingModel {
  bool? status;
  String? message;
  List<PayrollMappingItem>? data;

  PayrollMappingModel({this.status, this.message, this.data});

  PayrollMappingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PayrollMappingItem>[];
      json['data'].forEach((v) {
        data!.add(PayrollMappingItem.fromJson(v));
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

class PayrollMappingItem {
  int? id;
  int? ledgerId;
  int? fundId;
  Ledger? ledger;
  Fund? fund;

  PayrollMappingItem(
      {this.id,
        this.ledgerId,
        this.fundId,
        this.ledger,
        this.fund});

  PayrollMappingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ledgerId = json['ledger_id'];
    fundId = json['fund_id'];
    ledger =
    json['ledger'] != null ? Ledger.fromJson(json['ledger']) : null;
    fund = json['fund'] != null ? Fund.fromJson(json['fund']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ledger_id'] = ledgerId;
    data['fund_id'] = fundId;
    if (ledger != null) {
      data['ledger'] = ledger!.toJson();
    }
    if (fund != null) {
      data['fund'] = fund!.toJson();
    }
    return data;
  }
}

class Ledger {
  int? id;
  String? ledgerName;

  Ledger({this.id, this.ledgerName});

  Ledger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ledgerName = json['ledger_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ledger_name'] = ledgerName;
    return data;
  }
}

class Fund {
  int? id;
  String? name;

  Fund({this.id, this.name});

  Fund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
