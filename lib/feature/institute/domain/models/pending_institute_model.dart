class PendingInstituteModel {
  bool? status;
  String? message;
  Data? data;


  PendingInstituteModel({this.status, this.message, this.data, });

  PendingInstituteModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<PendingInstituteItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PendingInstituteItem>[];
      json['data'].forEach((v) {
        data!.add(PendingInstituteItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class PendingInstituteItem {
  int? id;
  CollectedData? collectedData;
  String? instituteLogo;
  String? userAvatar;
  String? status;
  String? approvedBy;
  String? approvedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PendingInstituteItem(
      {this.id,
        this.collectedData,
        this.instituteLogo,
        this.userAvatar,
        this.status,
        this.approvedBy,
        this.approvedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  PendingInstituteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectedData = json['collected_data'] != null
        ? CollectedData.fromJson(json['collected_data'])
        : null;
    instituteLogo = json['institute_logo'];
    userAvatar = json['user_avatar'];
    status = json['status'];
    approvedBy = json['approved_by'].toString();
    approvedAt = json['approved_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (collectedData != null) {
      data['collected_data'] = collectedData!.toJson();
    }
    data['institute_logo'] = instituteLogo;
    data['user_avatar'] = userAvatar;
    data['status'] = status;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class CollectedData {
  String? instituteName;
  String? instituteEmail;
  String? institutePhone;
  String? instituteDomain;
  String? instituteType;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? password;

  CollectedData(
      {this.instituteName,
        this.instituteEmail,
        this.institutePhone,
        this.instituteDomain,
        this.instituteType,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.password});

  CollectedData.fromJson(Map<String, dynamic> json) {
    instituteName = json['institute_name'];
    instituteEmail = json['institute_email'];
    institutePhone = json['institute_phone'];
    instituteDomain = json['institute_domain'];
    instituteType = json['institute_type'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['institute_name'] = instituteName;
    data['institute_email'] = instituteEmail;
    data['institute_phone'] = institutePhone;
    data['institute_domain'] = instituteDomain;
    data['institute_type'] = instituteType;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['password'] = password;
    return data;
  }
}




