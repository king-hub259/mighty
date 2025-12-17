class LeaveModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;


  LeaveModel({this.success, this.statusCode, this.message, this.data});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<LeaveItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <LeaveItem>[];
      json['data'].forEach((v) {
        data!.add(LeaveItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class LeaveItem {
  int? id;
  int? userId;
  int? leaveTypeId;
  String? startDate;
  String? endDate;
  int? days;
  String? evidence;
  String? notes;
  String? approvalStatus;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  Employee? employee;
  Employee? leaveType;

  LeaveItem(
      {this.id,
        this.userId,
        this.leaveTypeId,
        this.startDate,
        this.endDate,
        this.days,
        this.evidence,
        this.notes,
        this.approvalStatus,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.employee,
        this.leaveType});

  LeaveItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    leaveTypeId = json['leave_type_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    days = json['days'];
    evidence = json['evidence'];
    notes = json['notes'];
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    leaveType = json['leave_type'] != null
        ? Employee.fromJson(json['leave_type'])
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

