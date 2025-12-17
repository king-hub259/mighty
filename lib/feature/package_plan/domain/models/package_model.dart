class PackageModel {
  bool? status;
  String? message;
  Data? data;

  PackageModel({this.status, this.message, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
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
  List<PackageItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PackageItem>[];
      json['data'].forEach((v) {
        data!.add(PackageItem.fromJson(v));
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

class PackageItem {
  int? id;
  String? name;
  String? description;
  int? studentLimit;
  int? branchLimit;
  double? price;
  int? durationDays;
  int? isCustom;
  int? isFree;

  PackageItem(
      {this.id,
        this.name,
        this.description,
        this.studentLimit,
        this.branchLimit,
        this.price,
        this.durationDays,
        this.isCustom,
        this.isFree,
        });

  PackageItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    studentLimit = json['student_limit'];
    branchLimit = json['branch_limit'];
    price = double.parse(json['price'].toString());
    durationDays = json['duration_days'];
    isCustom = json['is_custom'];
    isFree = json['is_free'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['student_limit'] = studentLimit;
    data['branch_limit'] = branchLimit;
    data['price'] = price;
    data['duration_days'] = durationDays;
    data['is_custom'] = isCustom;
    data['is_free'] = isFree;
    return data;
  }
}

