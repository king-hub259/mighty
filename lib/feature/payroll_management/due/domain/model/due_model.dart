class DueModel {
  bool? status;
  String? message;
  Data? data;

  DueModel({this.status, this.message, this.data});

  DueModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.user, });

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}

class User {
  int? id;
  int? instituteId;
  int? branchId;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? roleId;

  User(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.roleId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['role_id'] = roleId;
    return data;
  }
}
