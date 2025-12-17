class FeesDateModel {
  bool? status;
  String? message;
  Data? data;


  FeesDateModel({this.status, this.message, this.data});

  FeesDateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<FeesDateItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesDateItem>[];
      json['data'].forEach((v) {
        data!.add(FeesDateItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class FeesDateItem {
  int? id;
  String? payableDateStart;
  String? payableDateEnd;
  String? feeSubHeadName;

  FeesDateItem(
      {this.id,
        this.payableDateStart,
        this.payableDateEnd,
        this.feeSubHeadName});

  FeesDateItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payableDateStart = json['payable_date_start'];
    payableDateEnd = json['payable_date_end'];
    feeSubHeadName = json['fee_sub_head_name'];
  }

}
