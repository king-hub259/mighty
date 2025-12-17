class PermissionModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  PermissionModel(
      {this.success, this.statusCode, this.message, this.data, });

  PermissionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<PermissionItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PermissionItem>[];
      json['data'].forEach((v) {
        data!.add(PermissionItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class PermissionItem {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  PermissionItem({this.id, this.name, this.guardName, this.createdAt, this.updatedAt, this.isSelected});

  PermissionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

