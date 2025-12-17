import 'package:mighty_school/helper/price_converter.dart';

class YearlyCashFlowDataModel {
  bool? status;
  String? message;
  List<IncomeExpense>? data;


  YearlyCashFlowDataModel({this.status, this.message, this.data});

  YearlyCashFlowDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IncomeExpense>[];
      json['data'].forEach((v) {
        data!.add(IncomeExpense.fromJson(v));
      });
    }

  }

}

class IncomeExpense {
  String? year;
  String? month;
  double? totalDebit;
  double? totalCredit;

  IncomeExpense({this.year, this.month, this.totalDebit, this.totalCredit});

  IncomeExpense.fromJson(Map<String, dynamic> json) {
    year = json['year'].toString();
    month = json['month'];
    totalDebit = PriceConverter.parseAmount(json['total_debit']);
    totalCredit = PriceConverter.parseAmount(json['total_credit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['total_debit'] = totalDebit;
    data['total_credit'] = totalCredit;
    return data;
  }
}
