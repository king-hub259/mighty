class PurchaseSmsModel {
  bool? status;
  String? message;
  Data? data;


  PurchaseSmsModel({this.status, this.message, this.data});

  PurchaseSmsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  
}

class Data {
  int? currentPage;
  List<PurchaseSmsItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PurchaseSmsItem>[];
      json['data'].forEach((v) {
        data!.add(PurchaseSmsItem.fromJson(v));
      });
    }
    total = json['total'];
  }
  
}

class PurchaseSmsItem {
  int? id;
  String? smsGateway;
  String? maskingType;
  String? transactionDate;
  String? noOfSms;
  String? amount;
  String? createdAt;
  String? updatedAt;

  PurchaseSmsItem(
      {this.id,
        this.smsGateway,
        this.maskingType,
        this.transactionDate,
        this.noOfSms,
        this.amount,
        this.createdAt,
        this.updatedAt});

  PurchaseSmsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smsGateway = json['sms_gateway'];
    maskingType = json['masking_type'];
    transactionDate = json['transaction_date'];
    noOfSms = json['no_of_sms'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
