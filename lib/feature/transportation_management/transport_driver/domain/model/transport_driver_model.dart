class TransportDriverModel {
  bool? status;
  String? message;
  Data? data;

  TransportDriverModel({this.status, this.message, this.data});

  TransportDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<TransportDriverItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransportDriverItem>[];
      json['data'].forEach((v) {
        data!.add(TransportDriverItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class TransportDriverItem {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? licenseNumber;
  String? licenseExpiry;
  String? experience;
  String? status;
  String? joiningDate;
  String? salary;
  String? image;
  String? createdAt;
  String? updatedAt;

  TransportDriverItem({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.licenseNumber,
    this.licenseExpiry,
    this.experience,
    this.status,
    this.joiningDate,
    this.salary,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  TransportDriverItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    licenseNumber = json['license_number'];
    licenseExpiry = json['license_expiry'];
    experience = json['experience'].toString();
    status = json['status'];
    joiningDate = json['joining_date'];
    salary = json['salary'].toString();
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['license_number'] = licenseNumber;
    data['license_expiry'] = licenseExpiry;
    data['experience'] = experience;
    data['status'] = status;
    data['joining_date'] = joiningDate;
    data['salary'] = salary;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}