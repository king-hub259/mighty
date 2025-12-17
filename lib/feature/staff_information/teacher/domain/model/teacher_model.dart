class TeacherModel {
  bool? status;
  String? message;
  Data? data;

  TeacherModel({this.status, this.message, this.data});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<TeacherItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TeacherItem>[];
      json['data'].forEach((v) {
        data!.add(TeacherItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class TeacherItem {
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
  String? teacherStatus;
  String? isAdministrator;

  TeacherItem(
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
        this.teacherStatus,
        this.isAdministrator});

  TeacherItem.fromJson(Map<String, dynamic> json) {
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
    teacherStatus = json['teacher_status'];
    isAdministrator = json['is_administrator'];
  }

}

