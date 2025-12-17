import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_model.dart';

class LibraryHistoryModel {
  bool? status;
  String? message;
  Data? data;

  LibraryHistoryModel({this.status, this.message, this.data});

  LibraryHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? phone;
  String? userType;
  String? image;
  int? instituteId;
  int? branchId;
  int? userId;
  int? libraryId;
  String? memberType;
  List<BookIssueItem>? issues;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.userType,
        this.image,
        this.instituteId,
        this.branchId,
        this.userId,
        this.libraryId,
        this.memberType,
        this.issues});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    image = json['image'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    libraryId = json['library_id'];
    memberType = json['member_type'];
    if (json['issues'] != null) {
      issues = <BookIssueItem>[];
      json['issues'].forEach((v) {
        issues!.add(BookIssueItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['image'] = image;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['library_id'] = libraryId;
    data['member_type'] = memberType;
    if (issues != null) {
      data['issues'] = issues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

