class SalarySlipModel {
  bool? status;
  String? message;
  SalarySlipItem? data;

  SalarySlipModel({this.status, this.message, this.data});

  SalarySlipModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SalarySlipItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SalarySlipItem {
  int? year;
  String? month;
  List<SalarySlips>? salarySlips;

  SalarySlipItem({this.year, this.month, this.salarySlips});

  SalarySlipItem.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    if (json['salary_slips'] != null) {
      salarySlips = <SalarySlips>[];
      json['salary_slips'].forEach((v) {
        salarySlips!.add(SalarySlips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    if (salarySlips != null) {
      data['salary_slips'] = salarySlips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalarySlips {
  User? user;
  List<SalaryHeads>? salaryHeads;
  List<SalaryHeadUserPayrolls>? salaryHeadUserPayrolls;
  bool isSelected = false;

  SalarySlips({this.user, this.salaryHeads, this.salaryHeadUserPayrolls, this.isSelected = false});

  SalarySlips.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['salary_heads'] != null) {
      salaryHeads = <SalaryHeads>[];
      json['salary_heads'].forEach((v) {
        salaryHeads!.add(SalaryHeads.fromJson(v));
      });
    }
    if (json['salary_head_user_payrolls'] != null) {
      salaryHeadUserPayrolls = <SalaryHeadUserPayrolls>[];
      json['salary_head_user_payrolls'].forEach((v) {
        salaryHeadUserPayrolls!.add(SalaryHeadUserPayrolls.fromJson(v));
      });
    }
    isSelected = json['isSelected'] ?? false;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (salaryHeads != null) {
      data['salary_heads'] = salaryHeads!.map((v) => v.toJson()).toList();
    }
    if (salaryHeadUserPayrolls != null) {
      data['salary_head_user_payrolls'] =
          salaryHeadUserPayrolls!.map((v) => v.toJson()).toList();
    }
    data['isSelected'] = isSelected;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? userType;
  UserPayroll? userPayroll;

  User({this.id, this.name, this.userType, this.userPayroll});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userType = json['user_type'];
    userPayroll = json['user_payroll'] != null
        ? UserPayroll.fromJson(json['user_payroll'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_type'] = userType;
    if (userPayroll != null) {
      data['user_payroll'] = userPayroll!.toJson();
    }
    return data;
  }
}

class UserPayroll {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  String? netSalary;
  String? currentDue;
  String? currentAdvance;
  String? createdAt;
  String? updatedAt;

  UserPayroll(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
        this.createdAt,
        this.updatedAt});

  UserPayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    netSalary = json['net_salary'];
    currentDue = json['current_due'];
    currentAdvance = json['current_advance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SalaryHeads {
  int? id;
  int? instituteId;
  int? branchId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  SalaryHeads(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.type,
        this.createdAt,
        this.updatedAt});

  SalaryHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SalaryHeadUserPayrolls {
  int? id;
  int? instituteId;
  int? branchId;
  int? userPayrollId;
  int? salaryHeadId;
  String? amount;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? netSalary;
  String? currentDue;
  String? currentAdvance;

  SalaryHeadUserPayrolls(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userPayrollId,
        this.salaryHeadId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance});

  SalaryHeadUserPayrolls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userPayrollId = json['user_payroll_id'];
    salaryHeadId = json['salary_head_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    netSalary = json['net_salary'];
    currentDue = json['current_due'];
    currentAdvance = json['current_advance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_payroll_id'] = userPayrollId;
    data['salary_head_id'] = salaryHeadId;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    return data;
  }
}
