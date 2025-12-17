class ReMarkConfigModel {
  bool? status;
  String? message;
  Data? data;

  ReMarkConfigModel({this.status, this.message, this.data});
  ReMarkConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }


}

class Data {int? currentPage;List<RemarkConfigItem>? data;int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RemarkConfigItem>[];
      json['data'].forEach((v) {
        data!.add(RemarkConfigItem.fromJson(v));
      });
    }

    total = json['total'];
  }

}

class RemarkConfigItem {
  int? id;
  String? remarkTitle;
  String? remarks;


  RemarkConfigItem(
      {this.id,
        this.remarkTitle,
        this.remarks,
      });

  RemarkConfigItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remarkTitle = json['remark_title'];
    remarks = json['remarks'];

  }


}


