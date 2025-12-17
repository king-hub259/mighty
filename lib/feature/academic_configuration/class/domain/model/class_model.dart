class ClassModel {
  bool? status;
  String? message;
  Data? data;


  ClassModel({this.status, this.message, this.data});

  ClassModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<ClassItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ClassItem>[];
      json['data'].forEach((v) {
        data!.add(ClassItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class ClassItem {
  int? id;
  String? className;
  String? status;
  String? createdAt;
  String? updatedAt;

  ClassItem({this.id, this.className, this.status, this.createdAt, this.updatedAt});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
