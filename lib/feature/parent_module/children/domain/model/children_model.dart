class ChildrenModel {
  bool? status;
  String? message;
  List<ChildrenItem>? data;


  ChildrenModel({this.status, this.message, this.data});

  ChildrenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChildrenItem>[];
      json['data'].forEach((v) {
        data!.add(ChildrenItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildrenItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  String? group;
  int? studentCategoryId;
  String? firstName;
  String? lastName;
  String? phone;
  int? registerNo;
  int? rollNo;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? status;
  int? parentId;
  String? nationality;
  String? createdAt;
  String? updatedAt;
  String? className;
  String? sectionName;

  ChildrenItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.group,
        this.studentCategoryId,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.fatherName,
        this.motherName,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.status,
        this.parentId,
        this.nationality,
        this.createdAt,
        this.updatedAt,
        this.className,
        this.sectionName});

  ChildrenItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    group = json['group'];
    studentCategoryId = json['student_category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'];
    rollNo = json['roll_no'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    status = json['status'];
    parentId = json['parent_id'];
    nationality = json['nationality'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class_name'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['group'] = group;
    data['student_category_id'] = studentCategoryId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['register_no'] = registerNo;
    data['roll_no'] = rollNo;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['address'] = address;
    data['status'] = status;
    data['parent_id'] = parentId;
    data['nationality'] = nationality;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    return data;
  }
}
