import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_model.dart';

class ParentAssignmentModel {
  bool? status;
  String? message;
  Data? data;


  ParentAssignmentModel({this.status, this.message, this.data});

  ParentAssignmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null && json['data'] is Map) ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<AssignmentItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AssignmentItem>[];
      json['data'].forEach((v) {
        data!.add(AssignmentItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}



