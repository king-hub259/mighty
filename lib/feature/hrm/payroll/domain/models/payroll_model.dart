class PayrollModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  PayrollModel({this.success, this.statusCode, this.message, this.data});
  PayrollModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }
}

class Data {
  int? currentPage;
  List<PayrollItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PayrollItem>[];
      json['data'].forEach((v) {
        data!.add(PayrollItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class PayrollItem {
  int? id;
  int? userId;
  String? date;
  String? reference;
  String? month;
  String? year;
  String? notes;
  String? amount;
  String? method;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? isActive;


  PayrollItem(
      {this.id,
        this.userId,
        this.date,
        this.reference,
        this.month,
        this.year,
        this.notes,
        this.amount,
        this.method,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  PayrollItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    reference = json['reference'];
    month = json['month'];
    year = json['year'];
    notes = json['notes'];
    amount = json['amount'];
    method = json['method'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
  }
}

