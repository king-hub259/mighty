class StudentLibraryModel {
  bool? status;
  String? message;
  LibraryItem? data;

  StudentLibraryModel({this.status, this.message, this.data});

  StudentLibraryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LibraryItem.fromJson(json['data']) : null;
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

class LibraryItem {
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
  String? teacherId;
  int? studentId;
  String? staffId;
  String? createdAt;
  String? updatedAt;
  List<Issues>? issues;

  LibraryItem(
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
        this.teacherId,
        this.studentId,
        this.staffId,
        this.createdAt,
        this.updatedAt,
        this.issues});

  LibraryItem.fromJson(Map<String, dynamic> json) {
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
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
    staffId = json['staff_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['issues'] != null) {
      issues = <Issues>[];
      json['issues'].forEach((v) {
        issues!.add(Issues.fromJson(v));
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
    data['teacher_id'] = teacherId;
    data['student_id'] = studentId;
    data['staff_id'] = staffId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (issues != null) {
      data['issues'] = issues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Issues {
  int? id;
  int? libraryId;
  String? issueDate;
  String? dueDate;
  String? returnDate;
  String? type;
  int? bookId;
  String? bookName;
  String? code;
  String? category;

  Issues(
      {this.id,
        this.libraryId,
        this.issueDate,
        this.dueDate,
        this.returnDate,
        this.type,
        this.bookId,
        this.bookName,
        this.code,
        this.category});

  Issues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libraryId = json['library_id'];
    issueDate = json['issue_date'];
    dueDate = json['due_date'];
    returnDate = json['return_date'];
    type = json['type'];
    bookId = json['book_id'];
    bookName = json['book_name'];
    code = json['code'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['library_id'] = libraryId;
    data['issue_date'] = issueDate;
    data['due_date'] = dueDate;
    data['return_date'] = returnDate;
    data['type'] = type;
    data['book_id'] = bookId;
    data['book_name'] = bookName;
    data['code'] = code;
    data['category'] = category;
    return data;
  }
}
