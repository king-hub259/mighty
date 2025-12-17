class StaffDetailsModel {
  bool? status;
  String? message;
  StaffInfo? data;


  StaffDetailsModel({this.status, this.message, this.data, });

  StaffDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? StaffInfo.fromJson(json['data']) : null;

  }

}

class StaffInfo {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? roleId;
  String? status;
  String? userStatus;
  String? userType;
  String? designation;
  String? birthday;
  String? gender;
  String? religion;
  String? sl;
  String? blood;
  String? address;
  String? staffStatus;
  String? isAdministrator;

  StaffInfo(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.roleId,
        this.status,
        this.userStatus,
        this.userType,
        this.designation,
        this.birthday,
        this.gender,
        this.religion,
        this.sl,
        this.blood,
        this.address,
        this.staffStatus,
        this.isAdministrator});

  StaffInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    roleId = json['role_id'];
    status = json['status'];
    userStatus = json['user_status'];
    userType = json['user_type'];
    designation = json['designation'];
    birthday = json['birthday'];
    gender = json['gender'];
    religion = json['religion'];
    sl = json['sl'];
    blood = json['blood'];
    address = json['address'];
    staffStatus = json['staff_status'];
    isAdministrator = json['is_administrator'];
  }

}
