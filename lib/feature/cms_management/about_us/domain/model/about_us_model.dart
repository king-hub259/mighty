class AboutUsModel {
  bool? status;
  String? message;
  Data? data;

  AboutUsModel({this.status, this.message, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
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
  List<AboutUsItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AboutUsItem>[];
      json['data'].forEach((v) {
        data!.add(AboutUsItem.fromJson(v));
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

class AboutUsItem {
  int? id;
  int? instituteId;
  String? title;
  String? heading;
  String? description;
  String? position;
  String? image;
  int? status;
  String? createdAt;

  AboutUsItem(
      {this.id,
        this.instituteId,
        this.title,
        this.heading,
        this.description,
        this.position,
        this.image,
        this.status,
        this.createdAt});

  AboutUsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    position = json['position'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['title'] = title;
    data['heading'] = heading;
    data['description'] = description;
    data['position'] = position;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}


