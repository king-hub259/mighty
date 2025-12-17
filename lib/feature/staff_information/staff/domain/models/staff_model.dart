class StaffModel {
  bool? status;
  String? message;
  Data? data;


  StaffModel({this.status, this.message, this.data});

  StaffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<StaffItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StaffItem>[];
      json['data'].forEach((v) {
        data!.add(StaffItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class StaffItem {
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

  StaffItem(
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

  StaffItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    roleId = json['role_id'].toString();
    status = json['status'].toString();
    userStatus = json['user_status'];
    userType = json['user_type'];
    designation = json['designation'];
    birthday = json['birthday'];
    gender = json['gender'];
    religion = json['religion'];
    sl = json['sl'].toString();
    blood = json['blood'];
    address = json['address'];
    staffStatus = json['staff_status'];
    isAdministrator = json['is_administrator'];
  }

}


