class RoleModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  RoleModel(
      {this.success, this.statusCode, this.message, this.data});

  RoleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<RoleItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RoleItem>[];
      json['data'].forEach((v) {
        data!.add(RoleItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class RoleItem {
  int? id;
  String? name;
  String? guardName;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<Permissions>? permissions;

  RoleItem(
      {this.id,
        this.name,
        this.guardName,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.permissions});

  RoleItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

}

class Permissions {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;

  Permissions(
      {this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}