class MeritProcessTypeModel {
  bool? status;
  String? message;
  Data? data;

  MeritProcessTypeModel({this.status, this.message, this.data});

  MeritProcessTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<MeritProcessTypeItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MeritProcessTypeItem>[];
      json['data'].forEach((v) {
        data!.add(MeritProcessTypeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class MeritProcessTypeItem {
  int? id;
  String? type;
  String? serial;
  bool? isSelected;


  MeritProcessTypeItem({this.id, this.type, this.serial, this.isSelected});

  MeritProcessTypeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    serial = json['serial'].toString();
    isSelected = false;

  }

}

