class FeesSubHeadModel {
  bool? status;
  String? message;
  Data? data;


  FeesSubHeadModel({this.status, this.message, this.data});
  FeesSubHeadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<FeesSubHeadItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,

        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesSubHeadItem>[];
      json['data'].forEach((v) {
        data!.add(FeesSubHeadItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class FeesSubHeadItem {
  int? id;
  String? feeHeadId;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;

  FeesSubHeadItem(
      {this.id,
        this.feeHeadId,
        this.name,
        this.serial,
        this.createdAt,
        this.updatedAt});

  FeesSubHeadItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeHeadId = json['fee_head_id'];
    name = json['name'];
    serial = json['serial'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

