class PayrollAssignBody {
  List<Users>? users;

  PayrollAssignBody({this.users});

  PayrollAssignBody.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  List<SalaryHeadItem>? salaryHeads;

  Users({this.userId, this.salaryHeads});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['salary_heads'] != null) {
      salaryHeads = <SalaryHeadItem>[];
      json['salary_heads'].forEach((v) {
        salaryHeads!.add(SalaryHeadItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (salaryHeads != null) {
      data['salary_heads'] = salaryHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalaryHeadItem {
  int? salaryHeadId;
  String? amount;

  SalaryHeadItem({this.salaryHeadId, this.amount});

  SalaryHeadItem.fromJson(Map<String, dynamic> json) {
    salaryHeadId = json['salary_head_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salary_head_id'] = salaryHeadId;
    data['amount'] = amount;
    return data;
  }
}
