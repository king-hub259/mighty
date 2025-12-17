import 'package:mighty_school/helper/price_converter.dart';

class AdvanceSalaryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AdvanceSalaryModel({this.success, this.statusCode, this.message, this.data});

  AdvanceSalaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<AdvanceSalaryItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AdvanceSalaryItem>[];
      json['data'].forEach((v) {
        data!.add(AdvanceSalaryItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class AdvanceSalaryItem {
  int? id;
  int? employeeId;
  double? amount;
  String? reason;
  String? requestDate;
  String? approvedDate;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;
  Employee? employee;

  AdvanceSalaryItem({
    this.id,
    this.employeeId,
    this.amount,
    this.reason,
    this.requestDate,
    this.approvedDate,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  AdvanceSalaryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    amount = PriceConverter.parseAmount(json['amount']);
    reason = json['reason'];
    requestDate = json['request_date'];
    approvedDate = json['approved_date'];
    status = json['status'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['amount'] = amount;
    data['reason'] = reason;
    data['request_date'] = requestDate;
    data['approved_date'] = approvedDate;
    data['status'] = status;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  Employee({this.id, this.firstName, this.lastName, this.email, this.phone});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class AdvanceSalaryBody {
  String? employeeId;
  String? amount;
  String? reason;
  String? requestDate;
  String? status;
  String? notes;

  AdvanceSalaryBody({
    this.employeeId,
    this.amount,
    this.reason,
    this.requestDate,
    this.status,
    this.notes,
  });

  AdvanceSalaryBody.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    amount = json['amount'];
    reason = json['reason'];
    requestDate = json['request_date'];
    status = json['status'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['amount'] = amount;
    data['reason'] = reason;
    data['request_date'] = requestDate;
    data['status'] = status;
    data['notes'] = notes;
    return data;
  }
}
