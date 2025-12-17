class SalaryHeadModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SalaryHeadModel({this.success, this.statusCode, this.message, this.data});

  SalaryHeadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<SalaryHeadItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SalaryHeadItem>[];
      json['data'].forEach((v) {
        data!.add(SalaryHeadItem.fromJson(v));
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

class SalaryHeadItem {
  int? id;
  String? name;
  String? type; // earning, deduction
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  SalaryHeadItem({
    this.id,
    this.name,
    this.type,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  SalaryHeadItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SalaryHeadBody {
  String? name;
  String? type;


  SalaryHeadBody({
    this.name,
    this.type,

  });

  SalaryHeadBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
