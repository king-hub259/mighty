

import '../../../../fees_management/smart_collection/domain/model/smart_collection_details_model.dart';

class AdmitCardModel {
  bool? status;
  String? message;
  Data? data;

  AdmitCardModel({this.status, this.message, this.data});

  AdmitCardModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? examName;
  List<AdmitCardItem>? data;

  Data({this.type, this.examName, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    examName = json['exam_name'];
    if (json['data'] != null) {
      data = <AdmitCardItem>[];
      json['data'].forEach((v) { data!.add(AdmitCardItem.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['exam_name'] = examName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdmitCardItem {
  int? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? sectionId;
  String? roll;
  String? optionalSubject;
  String? createdAt;
  String? updatedAt;
  Student? student;
  Session? session;
  ClassInfo? classInfo;
  Section? section;

  AdmitCardItem({this.id, this.sessionId, this.studentId, this.classId, this.sectionId, this.roll, this.optionalSubject, this.createdAt, this.updatedAt,
    this.student, this.session, this.classInfo, this.section});

  AdmitCardItem.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  sessionId = json['session_id'];
  studentId = json['student_id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  roll = json['roll'];
  optionalSubject = json['optional_subject'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  student = json['student'] != null ? Student.fromJson(json['student']) : null;
  session = json['session'] != null ? Session.fromJson(json['session']) : null;
  classInfo = json['class'] != null ? ClassInfo.fromJson(json['class']) : null;
  section = json['section'] != null ? Section.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['session_id'] = sessionId;
  data['student_id'] = studentId;
  data['class_id'] = classId;
  data['section_id'] = sectionId;
  data['roll'] = roll;
  data['optional_subject'] = optionalSubject;
  data['created_at'] = createdAt;
  data['updated_at'] = updatedAt;
  if (student != null) {
  data['student'] = student!.toJson();
  }
  if (session != null) {
  data['session'] = session!.toJson();
  }
  if (classInfo != null) {
  data['class'] = classInfo!.toJson();
  }
  if (section != null) {
  data['section'] = section!.toJson();
  }
  return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['status'] = status;
    return data;
  }
}

class StudentGroup {
  int? id;
  String? groupName;
  String? createdAt;
  String? updatedAt;

  StudentGroup({this.id, this.groupName, this.createdAt, this.updatedAt});

  StudentGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StudentCategory {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  StudentCategory({this.id, this.name, this.createdAt, this.updatedAt});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Session {
  int? id;
  String? session;
  String? year;
  String? createdAt;
  String? updatedAt;

  Session({this.id, this.session, this.year, this.createdAt, this.updatedAt});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session'] = session;
    data['year'] = year;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ClassInfo {
  int? id;
  String? className;
  String? status;
  String? createdAt;
  String? updatedAt;

  ClassInfo({this.id, this.className, this.status, this.createdAt, this.updatedAt});

  ClassInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Section {
  int? id;
  String? classId;
  String? studentGroupId;
  String? sectionName;
  String? roomNo;
  String? status;
  String? createdAt;
  String? updatedAt;

  Section({this.id, this.classId, this.studentGroupId, this.sectionName, this.roomNo, this.status, this.createdAt, this.updatedAt});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    studentGroupId = json['student_group_id'];
    sectionName = json['section_name'];
    roomNo = json['room_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_id'] = classId;
    data['student_group_id'] = studentGroupId;
    data['section_name'] = sectionName;
    data['room_no'] = roomNo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
