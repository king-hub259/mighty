class WhyChooseUsModel {
  bool? status;
  String? message;
  List<WhyChooseUsItem>? data;


  WhyChooseUsModel({this.status, this.message, this.data});

  WhyChooseUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WhyChooseUsItem>[];
      json['data'].forEach((v) {
        data!.add(WhyChooseUsItem.fromJson(v));
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

class WhyChooseUsItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? title;
  String? description;
  String? icon;
  String? createdAt;

  WhyChooseUsItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.title,
        this.description,
        this.icon,
        this.createdAt});

  WhyChooseUsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    return data;
  }
}
