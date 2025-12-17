class LibraryMemberModel {
  bool? status;
  String? message;
  Data? data;

  LibraryMemberModel({this.status, this.message, this.data});

  LibraryMemberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<LibraryMemberItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <LibraryMemberItem>[];
      json['data'].forEach((v) {
        data!.add(LibraryMemberItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class LibraryMemberItem {
  int? id;
  String? userId;
  String? libraryId;
  String? memberType;
  String? teacherId;
  String? studentId;
  String? staffId;
  String? createdAt;
  String? updatedAt;
  User? user;

  LibraryMemberItem(
      {this.id,
        this.userId,
        this.libraryId,
        this.memberType,
        this.teacherId,
        this.studentId,
        this.staffId,
        this.createdAt,
        this.updatedAt,
        this.user});

  LibraryMemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    libraryId = json['library_id'].toString();
    memberType = json['member_type'];
    teacherId = json['teacher_id'];
    studentId = json['student_id'].toString();
    staffId = json['staff_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }


}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;

  User({this.id, this.name, this.phone, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

}

