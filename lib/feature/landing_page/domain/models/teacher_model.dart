class TeacherModel {
  bool? status;
  String? message;
  List<TeacherItem>? data;

  TeacherModel({this.status, this.message, this.data});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TeacherItem>[];
      json['data'].forEach((v) {
        data!.add(TeacherItem.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class TeacherItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  int? departmentId;
  String? name;
  String? designation;
  User? user;

  TeacherItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.departmentId,
        this.name,
        this.designation,
        this.user});

  TeacherItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    departmentId = json['department_id'];
    name = json['name'];
    designation = json['designation'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['department_id'] = departmentId;
    data['name'] = name;
    data['designation'] = designation;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? googlePlus;

  User(
      {this.id,
        this.name,
        this.image,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.googlePlus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    googlePlus = json['google_plus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['google_plus'] = googlePlus;
    return data;
  }
}
