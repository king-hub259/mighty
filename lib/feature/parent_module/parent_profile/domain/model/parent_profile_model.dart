class ParentProfileModel {
  bool? status;
  String? message;
  Data? data;

  ParentProfileModel({this.status, this.message, this.data});

  ParentProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  int? studentId;
  String? parentName;
  String? parentProfession;
  String? parentPhone;
  String? presentAddress;
  String? permanentAddress;
  String? accessKey;
  User? user;
  Student? student;

  Data(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.studentId,
        this.parentName,
        this.parentProfession,
        this.parentPhone,
        this.presentAddress,
        this.permanentAddress,
        this.accessKey,
        this.user,
        this.student});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    studentId = json['student_id'];
    parentName = json['parent_name'];
    parentProfession = json['parent_profession'];
    parentPhone = json['parent_phone'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    accessKey = json['access_key'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['student_id'] = studentId;
    data['parent_name'] = parentName;
    data['parent_profession'] = parentProfession;
    data['parent_phone'] = parentPhone;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['access_key'] = accessKey;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User(
      {this.id,
        this.name,
        this.image,});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Student {
  int? id;
  String? group;
  String? firstName;
  String? lastName;
  String? phone;
  int? registerNo;
  int? rollNo;
  String? birthday;
  String? gender;
  String? bloodGroup;
  StudentSession? studentSession;
  Student(
      {this.id,
        this.group,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.studentSession});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'];
    rollNo = json['roll_no'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    studentSession = json['student_session'] != null ? StudentSession.fromJson(json['student_session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group'] = group;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['register_no'] = registerNo;
    data['roll_no'] = rollNo;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    if (studentSession != null) {
      data['student_session'] = studentSession!.toJson();
    }
    return data;
  }
}
class StudentSession {
  ClassItem? classItem;
  Section? section;

  StudentSession({this.classItem, this.section});

  StudentSession.fromJson(Map<String, dynamic> json) {
    classItem = json['class'] != null ? ClassItem.fromJson(json['class']) : null;
    section =
    json['section'] != null ? Section.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    return data;
  }
}

class ClassItem {
  String? className;
  ClassItem({this.className});

  ClassItem.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_name'] = className;
    return data;
  }
}

class Section {
  String? sectionName;

  Section({this.sectionName});

  Section.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_name'] = sectionName;
    return data;
  }
}