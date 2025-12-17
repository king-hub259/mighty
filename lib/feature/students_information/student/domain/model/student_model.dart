import 'package:flutter/cupertino.dart';

class StudentModel {
  bool? status;
  String? message;
  List<StudentItem>? data;


  StudentModel({this.status, this.message, this.data});

  StudentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentItem>[];
      json['data'].forEach((v) {
        data!.add(StudentItem.fromJson(v));
      });
    }
  }

}

class StudentItem {
  int? id;
  String? name;
  String? image;
  String? phone;
  String? registerNo;
  String? fatherName;
  String? motherName;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? status;
  String? nationality;
  String? createdAt;
  String? updatedAt;
  String? roll;
  String? prevRoll;
  String? newRoll;
  String? className;
  String? sectionName;
  String? groupName;
  Class? classItem;
  Section? section;
  TextEditingController? newRollController;
  bool? isSelected = false;


  StudentItem(
      {this.id,
        this.name,
        this.image,
        this.phone,
        this.registerNo,
        this.fatherName,
        this.motherName,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.status,
        this.nationality,
        this.createdAt,
        this.updatedAt,
        this.roll,
        this.prevRoll,
        this.newRoll,
        this.className,
        this.sectionName,
        this.groupName,
        this.classItem,
        this.section,
        this.newRollController,
        this.isSelected
      });

  StudentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    registerNo = json['register_no'].toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    status = json['status'].toString();
    nationality = json['nationality'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roll = json['roll'];
    prevRoll = json['prev_roll'];
    newRoll = json['new_roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    groupName = json['group_name'];
    classItem = json['class'] != null ? Class.fromJson(json['class']) : null;
    section = json['section'] != null ? Section.fromJson(json['section']) : null;
    newRollController = TextEditingController(text: json['roll']);
    isSelected = false;
  }

}

class Section {
  String? sectionName;
  Section({this.sectionName});
  Section.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
  }
}

class Class {
  String? className;
  Class({this.className});
  Class.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
  }
}