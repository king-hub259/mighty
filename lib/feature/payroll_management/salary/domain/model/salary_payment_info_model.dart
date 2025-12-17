import 'package:mighty_school/helper/price_converter.dart';

class SalaryPaymentInfoModel {
  bool? status;
  String? message;
  List<SalaryPaymentInfoItem>? data;

  SalaryPaymentInfoModel({this.status, this.message, this.data});

  SalaryPaymentInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SalaryPaymentInfoItem>[];
      json['data'].forEach((v) {
        data!.add(SalaryPaymentInfoItem.fromJson(v));
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

class SalaryPaymentInfoItem {
  int? hrId;
  String? hrName;
  String? invoiceId;
  String? paymentType;
  double? netSalary;
  double? payableSalary;
  double? paid;
  double? due;
  double? advance;
  String? paymentDate;

  SalaryPaymentInfoItem(
      {this.hrId,
        this.hrName,
        this.invoiceId,
        this.paymentType,
        this.netSalary,
        this.payableSalary,
        this.paid,
        this.due,
        this.advance,
        this.paymentDate});

  SalaryPaymentInfoItem.fromJson(Map<String, dynamic> json) {
    hrId = json['hr_id'];
    hrName = json['hr_name'];
    invoiceId = json['invoice_id'];
    paymentType = json['payment_type'];
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    payableSalary = PriceConverter.parseAmount(json['payable_salary']);
    paid = PriceConverter.parseAmount(json['paid']);
    due = PriceConverter.parseAmount(json['due']);
    advance = PriceConverter.parseAmount(json['advance']);
    paymentDate = json['payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hr_id'] = hrId;
    data['hr_name'] = hrName;
    data['invoice_id'] = invoiceId;
    data['payment_type'] = paymentType;
    data['net_salary'] = netSalary;
    data['payable_salary'] = payableSalary;
    data['paid'] = paid;
    data['due'] = due;
    data['advance'] = advance;
    data['payment_date'] = paymentDate;
    return data;
  }
}
