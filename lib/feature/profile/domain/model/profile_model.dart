class ProfileModel {
  bool? status;
  String? message;
  Data? data;


  ProfileModel({this.status, this.message, this.data, });

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? instituteId;
  int? branchId;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? role;
  int? status;
  InstituteInfo? instituteInfo;
  List<String>? permissions;
  String? emailVerifiedAt;
  String? createdAt;



  Data(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.role,
        this.status,
        this.instituteInfo,
        this.permissions,
        this.emailVerifiedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    status = json['status'];
    instituteInfo = json['institute_info'] != null ? InstituteInfo.fromJson(json['institute_info']) : null;
    permissions = json['permissions'].cast<String>();
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['role'] = role;
    data['status'] = status;
    if (instituteInfo != null) {
      data['institute_info'] = instituteInfo!.toJson();
    }
    data['permissions'] = permissions;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
class InstituteInfo {
  int? id;
  String? name;
  bool? status;
  Subscription? subscription;

  InstituteInfo({this.id, this.name, this.status, this.subscription});

  InstituteInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  int? id;
  int? instituteId;
  int? planId;
  String? startDate;
  String? endDate;
  String? status;
  Plan? plan;

  Subscription(
      {this.id,
        this.instituteId,
        this.planId,
        this.startDate,
        this.endDate,
        this.status,
        this.plan});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['plan_id'] = planId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    return data;
  }
}

class Plan {
  int? id;
  String? name;

  Plan({this.id, this.name});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}