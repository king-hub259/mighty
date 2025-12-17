import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';

class ParentSyllabusModel {
  bool? status;
  String? message;
  List<SyllabusItem>? data;

  ParentSyllabusModel({this.status, this.message, this.data});

  ParentSyllabusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SyllabusItem>[];
      json['data'].forEach((v) {
        data!.add(SyllabusItem.fromJson(v));
      });
    }
  }

}




