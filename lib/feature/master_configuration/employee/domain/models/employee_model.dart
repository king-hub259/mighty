import 'package:mighty_school/helper/price_converter.dart';

class EmployeeModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  EmployeeModel(
      {this.success, this.statusCode, this.message, this.data,});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<EmployeeItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <EmployeeItem>[];
      json['data'].forEach((v) {
        data!.add(EmployeeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class EmployeeItem {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? nid;
  String? departmentId;
  String? address;
  String? avatar;
  String? phone;
  int? roleId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? department;
  String? role;
  String? presentType;
  String? checkIn;
  String? checkOut;

  EmployeeItem(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.nid,
        this.departmentId,
        this.address,
        this.avatar,
        this.phone,
        this.roleId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.department,
        this.role});

  EmployeeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nid = json['nid'];
    departmentId = json['department_id'];
    address = json['address'];
    avatar = json['avatar'];
    phone = json['phone'];
    roleId = PriceConverter.parseInt(json['role_id']);
    status = PriceConverter.parseInt(json['status']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    department = json['user_type'];
    role = json['role'];
  }
}



