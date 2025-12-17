class PickListModel {
  bool? status;
  String? message;
  Data? data;


  PickListModel({this.status, this.message, this.data});

  PickListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<PickListItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PickListItem>[];
      json['data'].forEach((v) {
        data!.add(PickListItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class PickListItem {
  int? id;
  String? type;
  String? value;

  PickListItem({this.id, this.type, this.value});

  PickListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
  }

}

