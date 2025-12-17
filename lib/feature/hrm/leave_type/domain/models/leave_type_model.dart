class LeaveTypeModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  LeaveTypeModel(
      {this.success, this.statusCode, this.message, this.data});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<LeaveTypeItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <LeaveTypeItem>[];
      json['data'].forEach((v) {
        data!.add(LeaveTypeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class LeaveTypeItem {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? isActive;


  LeaveTypeItem(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isActive,
      });

  LeaveTypeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];

  }

}

