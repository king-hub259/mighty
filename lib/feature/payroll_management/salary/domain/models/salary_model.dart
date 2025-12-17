class SalaryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SalaryModel({this.success, this.statusCode, this.message, this.data});

  SalaryModel.fromJson(Map<String, dynamic> json) {
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
  List<SalaryItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SalaryItem>[];
      json['data'].forEach((v) {
        data!.add(SalaryItem.fromJson(v));
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

class SalaryItem {
  int? id;
  int? employeeId;
  String? month;
  String? year;
  String? basicSalary;
  String? totalEarning;
  String? totalDeduction;
  String? netSalary;
  String? status;
  String? processedAt;
  String? createdAt;
  String? updatedAt;
  Employee? employee;
  List<SalaryDetails>? salaryDetails;

  SalaryItem({
    this.id,
    this.employeeId,
    this.month,
    this.year,
    this.basicSalary,
    this.totalEarning,
    this.totalDeduction,
    this.netSalary,
    this.status,
    this.processedAt,
    this.createdAt,
    this.updatedAt,
    this.employee,
    this.salaryDetails,
  });

  SalaryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    month = json['month'];
    year = json['year'];
    basicSalary = json['basic_salary'];
    totalEarning = json['total_earning'];
    totalDeduction = json['total_deduction'];
    netSalary = json['net_salary'];
    status = json['status'];
    processedAt = json['processed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    if (json['salary_details'] != null) {
      salaryDetails = <SalaryDetails>[];
      json['salary_details'].forEach((v) {
        salaryDetails!.add(SalaryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['month'] = month;
    data['year'] = year;
    data['basic_salary'] = basicSalary;
    data['total_earning'] = totalEarning;
    data['total_deduction'] = totalDeduction;
    data['net_salary'] = netSalary;
    data['status'] = status;
    data['processed_at'] = processedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (salaryDetails != null) {
      data['salary_details'] = salaryDetails!.map((v) => v.toJson()).toList();
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
  String? designation;

  Employee({this.id, this.firstName, this.lastName, this.email, this.phone, this.designation});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['designation'] = designation;
    return data;
  }
}

class SalaryDetails {
  int? id;
  int? salaryId;
  int? salaryHeadId;
  String? amount;
  String? type;
  SalaryHead? salaryHead;

  SalaryDetails({
    this.id,
    this.salaryId,
    this.salaryHeadId,
    this.amount,
    this.type,
    this.salaryHead,
  });

  SalaryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salaryId = json['salary_id'];
    salaryHeadId = json['salary_head_id'];
    amount = json['amount'];
    type = json['type'];
    salaryHead = json['salary_head'] != null ? SalaryHead.fromJson(json['salary_head']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['salary_id'] = salaryId;
    data['salary_head_id'] = salaryHeadId;
    data['amount'] = amount;
    data['type'] = type;
    if (salaryHead != null) {
      data['salary_head'] = salaryHead!.toJson();
    }
    return data;
  }
}

class SalaryHead {
  int? id;
  String? name;
  String? type;

  SalaryHead({this.id, this.name, this.type});

  SalaryHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
