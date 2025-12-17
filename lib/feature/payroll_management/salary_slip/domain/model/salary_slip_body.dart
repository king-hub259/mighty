class SalarySlipBody {
  int? year;
  int? month;
  List<Users>? users;

  SalarySlipBody({this.year, this.month, this.users});

  SalarySlipBody.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  List<SalaryHeads>? salaryHeads;

  Users({this.userId, this.salaryHeads});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['salary_heads'] != null) {
      salaryHeads = <SalaryHeads>[];
      json['salary_heads'].forEach((v) {
        salaryHeads!.add(SalaryHeads.fromJson(v));
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

class SalaryHeads {
  int? salaryHeadId;
  String? amount;

  SalaryHeads({this.salaryHeadId, this.amount});

  SalaryHeads.fromJson(Map<String, dynamic> json) {
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
