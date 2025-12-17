class FeesHeadModel {
  bool? status;
  String? message;
  Data? data;


  FeesHeadModel({this.status, this.message, this.data});

  FeesHeadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<FeesHeadItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesHeadItem>[];
      json['data'].forEach((v) {
        data!.add(FeesHeadItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class FeesHeadItem {
  int? id;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;


  FeesHeadItem(
      {this.id,
        this.name,
        this.serial,
        this.createdAt,
        this.updatedAt});

  FeesHeadItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = json['serial'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

