class StudentDetailsModel {
  bool? status;
  String? message;
  StudentDetailsItem? data;


  StudentDetailsModel({this.status, this.message, this.data});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? StudentDetailsItem.fromJson(json['data']) : null;
  }

}

class StudentDetailsItem {
  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? rollNo;
  String? group;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? state;
  String? country;
  String? studentCategoryId;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  StudentDetailsItem(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.group,
        this.fatherName,
        this.motherName,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.state,
        this.country,
        this.studentCategoryId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user});

  StudentDetailsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'];
    rollNo = json['roll_no'];
    group = json['group'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    studentCategoryId = json['student_category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? status;

  User({this.id, this.name, this.email, this.phone, this.image, this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    status = json['status'];
  }
}
