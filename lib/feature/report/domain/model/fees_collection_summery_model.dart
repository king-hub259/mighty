import 'package:mighty_school/helper/price_converter.dart';

class FeesCollectionSummeryModel {
  bool? status;
  String? message;
  List<FeesCollectionSummeryItem>? data;

  FeesCollectionSummeryModel(
      {this.status, this.message, this.data});

  FeesCollectionSummeryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeesCollectionSummeryItem>[];
      json['data'].forEach((v) {
        data!.add(FeesCollectionSummeryItem.fromJson(v));
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

class FeesCollectionSummeryItem {
  String? month;
  double? collected;
  double? outstanding;

  FeesCollectionSummeryItem({this.month, this.collected, this.outstanding});

  FeesCollectionSummeryItem.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    collected = PriceConverter.parseAmount(json['collected']);
    outstanding = PriceConverter.parseAmount(json['outstanding']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['collected'] = collected;
    data['outstanding'] = outstanding;
    return data;
  }
}
