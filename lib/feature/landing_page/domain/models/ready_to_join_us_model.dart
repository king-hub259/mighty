class ReadyToJoinUsModel {
  bool? status;
  String? message;
  List<ReadyToJoinUsItem>? data;


  ReadyToJoinUsModel({this.status, this.message, this.data});

  ReadyToJoinUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReadyToJoinUsItem>[];
      json['data'].forEach((v) {
        data!.add(ReadyToJoinUsItem.fromJson(v));
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

class ReadyToJoinUsItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? title;
  String? description;
  String? icon;
  String? buttonName;
  String? buttonLink;
  String? createdAt;

  ReadyToJoinUsItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.title,
        this.description,
        this.icon,
        this.buttonName,
        this.buttonLink,
        this.createdAt});

  ReadyToJoinUsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    buttonName = json['button_name'];
    buttonLink = json['button_link'];
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
    data['button_name'] = buttonName;
    data['button_link'] = buttonLink;
    data['created_at'] = createdAt;
    return data;
  }
}
