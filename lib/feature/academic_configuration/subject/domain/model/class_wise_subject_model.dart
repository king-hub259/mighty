import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';

class ClassWiseSubjectModel {
  bool? status;
  String? message;
  List<SubjectItem>? data;


  ClassWiseSubjectModel({this.status, this.message, this.data});

  ClassWiseSubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubjectItem>[];
      json['data'].forEach((v) {
        data!.add(SubjectItem.fromJson(v));
      });
    }

  }
}


