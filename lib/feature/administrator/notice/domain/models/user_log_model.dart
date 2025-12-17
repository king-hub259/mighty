class UserLogModel {
  bool? status;
  String? message;
  Data? data;

  UserLogModel({this.status, this.message, this.data});

  UserLogModel.fromJson(Map<String, dynamic> json) {
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
  List<UserLogItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <UserLogItem>[];
      json['data'].forEach((v) {
        data!.add(UserLogItem.fromJson(v));
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

class UserLogItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  String? ipAddress;
  String? action;
  String? detail;
  String? model;
  int? modelId;
  String? url;
  String? createdAt;
  String? updatedAt;
  User? user;

  UserLogItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.ipAddress,
        this.action,
        this.detail,
        this.model,
        this.modelId,
        this.url,
        this.createdAt,
        this.updatedAt,
        this.user});

  UserLogItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    ipAddress = json['ip_address'];
    action = json['action'];
    detail = json['detail'];
    model = json['model'];
    modelId = json['model_id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['ip_address'] = ipAddress;
    data['action'] = action;
    data['detail'] = detail;
    data['model'] = model;
    data['model_id'] = modelId;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
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


