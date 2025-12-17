class DepartmentModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  DepartmentModel(
      {this.success, this.statusCode, this.message, this.data});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<DepartmentItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DepartmentItem>[];
      json['data'].forEach((v) {
        data!.add(DepartmentItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class DepartmentItem {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? isActive;

  DepartmentItem(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  DepartmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['department_name'];
    description = json['priority'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
  }
}

