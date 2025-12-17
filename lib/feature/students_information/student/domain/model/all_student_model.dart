import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';

class AllStudentModel {
  bool? status;
  String? message;
  Data? data;
  AllStudentModel({this.status, this.message, this.data});

  AllStudentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<StudentItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StudentItem>[];
      json['data'].forEach((v) {
        data!.add(StudentItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}



