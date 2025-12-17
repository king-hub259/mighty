class WaiverModel {
  bool? status;
  String? message;
  Data? data;


  WaiverModel({this.status, this.message, this.data});

  WaiverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }


}

class Data {
  int? currentPage;
  List<WaiverItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <WaiverItem>[];
      json['data'].forEach((v) {
        data!.add(WaiverItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class WaiverItem {
  int? id;
  String? waiver;
  String? createdAt;
  String? updatedAt;

  WaiverItem({this.id, this.waiver, this.createdAt, this.updatedAt});

  WaiverItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    waiver = json['waiver'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
