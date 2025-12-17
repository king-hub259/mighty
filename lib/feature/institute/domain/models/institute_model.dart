class InstituteModel {
  bool? status;
  String? message;
  Data? data;


  InstituteModel({this.status, this.message, this.data, });

  InstituteModel.fromJson(Map<String, dynamic> json) {
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
  List<InstituteItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <InstituteItem>[];
      json['data'].forEach((v) {
        data!.add(InstituteItem.fromJson(v));
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

class InstituteItem {
  int? id;
  String? ownerId;
  String? assignedTo;
  String? ownerName;
  String? assignedName;
  String? name;
  String? email;
  String? address;
  String? instituteType;
  String? phone;
  String? domain;
  String? platform;
  String? logo;
  int? status;
  String? createdAt;


  InstituteItem(
      {this.id,
        this.ownerId,
        this.assignedTo,
        this.ownerName,
        this.assignedName,
        this.name,
        this.email,
        this.address,
        this.instituteType,
        this.phone,
        this.domain,
        this.platform,
        this.logo,
        this.status,
        this.createdAt});

  InstituteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    assignedTo = json['assigned_to'];
    ownerName = json['owner_name'];
    assignedName = json['assigned_name'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    instituteType = json['institute_type'];
    phone = json['phone'];
    domain = json['domain'];
    platform = json['platform'];
    logo = json['logo'];
    status = json['status'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['assigned_to'] = assignedTo;
    data['owner_name'] = ownerName;
    data['assigned_name'] = assignedName;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['institute_type'] = instituteType;
    data['phone'] = phone;
    data['domain'] = domain;
    data['platform'] = platform;
    data['logo'] = logo;
    data['status'] = status;
    data['created_at'] = createdAt;

    return data;
  }
}

