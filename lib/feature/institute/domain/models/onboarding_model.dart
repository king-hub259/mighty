class OnboardingModel {
  bool? status;
  String? message;
  Data? data;

  OnboardingModel({this.status, this.message, this.data});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  User? user;
  String? accessToken;

  Data({this.user, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    return data;
  }
}

class User {
  int? instituteId;
  int? branchId;
  String? name;
  String? email;
  String? phone;
  int? roleId;
  String? userType;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.instituteId,
        this.branchId,
        this.name,
        this.email,
        this.phone,
        this.roleId,
        this.userType,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['role_id'];
    userType = json['user_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role_id'] = roleId;
    data['user_type'] = userType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
