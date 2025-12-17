class EmployeeBody {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? userType;
  int? roleId;

  EmployeeBody(
      {this.name,
        this.email,
        this.phone,
        this.password,
        this.passwordConfirmation,
        this.userType,
        this.roleId});

  EmployeeBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    userType = json['user_type'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['user_type'] = userType;
    data['role_id'] = roleId;
    return data;
  }
}
