class AttendanceModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  AttendanceModel(
      {this.success, this.statusCode, this.message, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }
}

class Data {
  int? currentPage;
  List<AttendanceItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AttendanceItem>[];
      json['data'].forEach((v) {
        data!.add(AttendanceItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class AttendanceItem {
  int? id;
  int? userId;
  String? date;
  String? checkIn;
  String? checkOut;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  Employee? employee;

  AttendanceItem(
      {this.id,
        this.userId,
        this.date,
        this.checkIn,
        this.checkOut,
        this.status,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.employee});

  AttendanceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['attendance'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }
}

class Employee {
  int? id;
  String? name;

  Employee({this.id, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

